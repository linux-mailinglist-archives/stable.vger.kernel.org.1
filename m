Return-Path: <stable+bounces-181671-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B015B9DD55
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 09:18:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACB391B25489
	for <lists+stable@lfdr.de>; Thu, 25 Sep 2025 07:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5168C42A82;
	Thu, 25 Sep 2025 07:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txAtAboS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6072BB13
	for <stable@vger.kernel.org>; Thu, 25 Sep 2025 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758784719; cv=none; b=mP6uqoNtzC/MNW4P+gC+M6ZMR+HfpUKtxTgApB3MXzlm2lCjIgk9ilwV+ZykRCRsSvc6rEiew0bJ8GMtYL9tLkwHXNoQ+6jA5D38bVexSKkxURp8um3jLNhg+QwiLudsmAjvdpNH46glTzDd0rYcJhTAzzSXJIj8+QhOHYZu/To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758784719; c=relaxed/simple;
	bh=H/Td20vC4ftXPsIttpjuHXAeI5w8WhJo/tjrWvoO8rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JvQa/M0jg5C/F4gqLIrxDPdoNacYGpsFff/yrJOZX6bc9vQTBtprWgM8xbpW0jzeS3UIgquqnIWIiONFMiAQtWm4R5GDrFbbPJAzFeOEO6KuZgMvuaZ0v/+JndhWtr2lfICIbcNQLQuIhYvhnFldE6MDcp2RpJvAHWkwt7oBvEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txAtAboS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3F8C4CEF0;
	Thu, 25 Sep 2025 07:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758784718;
	bh=H/Td20vC4ftXPsIttpjuHXAeI5w8WhJo/tjrWvoO8rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=txAtAboSMVq1D8QWNpPJpsD3IwrJIn7XqaN5Zk/YmFhwcApnRuE+pQ6Bn+Fv3xMYi
	 go9cfl3RsA6rqptOTXbLthG0DPsX0lGjUPasp3GOAOpxqQPlkB35HkoyecqTrDHVfo
	 eCbbdDu8W6wr5dCpdD6O6JwWdV9l/YGIoE89q5iXraZfVCmMThi3zSgY04JV5tkZH+
	 Mt2DrTqwkb5t7bKYInDYqw+nfBUcNq7SM+5rFGvB6u8XPohds1PeMQWDsFb1hQ9Z6x
	 uRRhzFy1xrt2SKM/CJW1ouaLm8dl/leiIcL2hoKisVLZRx9QEvj0AdAqYqd1ESyKvi
	 GaxXYWrtmbTqA==
From: Christian Brauner <brauner@kernel.org>
To: dhowells@redhat.com,
	marc.dionne@auristor.com,
	Zhen Ni <zhen.ni@easystack.cn>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] afs: Fix potential null pointer dereference in afs_put_server
Date: Thu, 25 Sep 2025 09:18:32 +0200
Message-ID: <20250925-erfassen-wucher-7f503b1bb462@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20250923075104.1141803-1-zhen.ni@easystack.cn>
References: <20250923075104.1141803-1-zhen.ni@easystack.cn>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Developer-Signature: v=1; a=openpgp-sha256; l=1042; i=brauner@kernel.org; h=from:subject:message-id; bh=H/Td20vC4ftXPsIttpjuHXAeI5w8WhJo/tjrWvoO8rk=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRceXPKPyqD8dL52PptJbG6d55KLV2YrSX+U67aSHL6b KOmSXt4O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbyuILhf1Cz1ZJ454xFl3aE zf++k7vhbNKzrqWzZ3xXnhHxw3j/4vmMDDOOhMXrXanlf1OYPtl2598W21UhbBP3WXmFMIdJLH5 hxwIA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

On Tue, 23 Sep 2025 15:51:04 +0800, Zhen Ni wrote:
> afs_put_server() accessed server->debug_id before the NULL check, which
> could lead to a null pointer dereference. Move the debug_id assignment,
> ensuring we never dereference a NULL server pointer.
> 
> 

Applied to the vfs.fixes branch of the vfs/vfs.git tree.
Patches in the vfs.fixes branch should appear in linux-next soon.

Please report any outstanding bugs that were missed during review in a
new review to the original patch series allowing us to drop it.

It's encouraged to provide Acked-bys and Reviewed-bys even though the
patch has now been applied. If possible patch trailers will be updated.

Note that commit hashes shown below are subject to change due to rebase,
trailer updates or similar. If in doubt, please check the listed branch.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
branch: vfs.fixes

[1/1] afs: Fix potential null pointer dereference in afs_put_server
      https://git.kernel.org/vfs/vfs/c/9158c6bb2451

