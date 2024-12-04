Return-Path: <stable+bounces-98325-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F609E4020
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:53:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1EF4A167607
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 16:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 253B420CCFB;
	Wed,  4 Dec 2024 16:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTrcTNq4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9CD20CCF4
	for <stable@vger.kernel.org>; Wed,  4 Dec 2024 16:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331193; cv=none; b=ChOk3o/99Ty3lDU+yMa+tJp55u3cSkYbZNs3py/6qvtEizjKzAWMNY/UitwFd7WYaQ0Nt+bb4pbGtvwjSfThDcN7cIRIciLK5a5i478Kak/S167Gb7GvmjRktr0owu1JKecUUom+cQ++0INi1NryHbjfzsNZPbmfDT1w1dYxg5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331193; c=relaxed/simple;
	bh=ZzrkxB4NsdcDdx4AFk9SK1tI2Gz9PJNHQFJSFWD0QuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7MjuMJB94DuH2MJ6YcXNWy/SgvPEwOHPgUAPn3QNE/wT+YHgCNWOL/Ne4FD9KACIyEid0cPN0O/NGgDUFTmNMmW4IdMhFRtRaS/eZdVryEuuzrEpijnQk0Jo9PN7VSdX7QAsWYkUUNcG3yCHYn2HIboyIGH4PCsXvLJyusLn9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uTrcTNq4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4789C4CECD;
	Wed,  4 Dec 2024 16:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331193;
	bh=ZzrkxB4NsdcDdx4AFk9SK1tI2Gz9PJNHQFJSFWD0QuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uTrcTNq4f5vhgItYGVZo8cK490LQU3TLrfQ72HUfBteg35ib5Q415h6J+F+cRdVvc
	 0R/EIsWWrIlKocmMa01y8ZsdHk9YdlKIjvTjoEpP4D68+qCojdflKNgX6SFVr7sXb3
	 YjIur2NikFYwSkEe3m+BupVtOCn5dzrvJp1JhfD/twPBX8BxbsQlXEZPbDSWNeGCTs
	 DoxyDmJs7jS+oif4sa4N0uU4GL6h8LIGOJ+O3Vh7csA++1y4IAExJp9XiWsCSgfwZb
	 aOElkF0fd9QlglEl4ZoKtLDdS+qhXkC8qfHVCI6ge8wW+xJdrpeF0DH6nDs59kQXP/
	 bgg41Vndkqcbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zhang Zekun <zhangzekun11@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 4.19] Revert "drm/amdgpu: add missing size check in amdgpu_debugfs_gprwave_read()"
Date: Wed,  4 Dec 2024 10:41:53 -0500
Message-ID: <20241204065037-447ae17be805de83@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241204082231.129924-1-zhangzekun11@huawei.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

No upstream commit was identified. Using temporary commit for testing.

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-4.19.y       |  Success    |  Success   |

