Return-Path: <stable+bounces-192654-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A9BC3D953
	for <lists+stable@lfdr.de>; Thu, 06 Nov 2025 23:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F279188FCCA
	for <lists+stable@lfdr.de>; Thu,  6 Nov 2025 22:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30A0B3126BE;
	Thu,  6 Nov 2025 22:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cquHx+uV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D912326ED29;
	Thu,  6 Nov 2025 22:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762467727; cv=none; b=BYLyDDqmfbMlVcGBVTW30x4ApTBr5Eb26066vjKMAmmtLqOqq8z8BTj15cRPZrTXzCLueJnw8cmF7S0fS/EjzWfMqSZUZDS5yaHn4gPhYiAPoBMLgOmI3liLws5Ed57jRbkQr73Kz2TNUMa7sCbE9hR1cUh2RzYyWORgy/IXbjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762467727; c=relaxed/simple;
	bh=p3L6FERv2ep+nENXovBzYWn++aCR71MS9mNcjMlGX74=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=URNqB+tUl1Vdz5UBBWJzOiBYmdY6fJeOC5766zA/c8+euefxhIcEL4IBPkVfUuOXbcpsrRkox0hSbmEgpXkQJMDyxcSnkNhj0BPMQ+Chps0obZy5C6qWmJVnuhvyliy7ATOiXd/624JZcHHZTBkVaTPjI+76sKZc497cY3w1qFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cquHx+uV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DB45C4CEF7;
	Thu,  6 Nov 2025 22:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762467726;
	bh=p3L6FERv2ep+nENXovBzYWn++aCR71MS9mNcjMlGX74=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cquHx+uVsXtOEKKVhs22vbVpF+FHBjeX8+ILIm9PWBAUamao6w78QgZ1RRuKMzMiI
	 Ep4Snw7cPrCuAw6xuWGmq21p0/S/SnYgcPbAYiRzBeanh5YgUhoiX9BVFmPPRXUO9V
	 f1e5p+S5zmsajhV1HYoQUbYt70UNmzyB85EwuNV01xt7LKX/CVdF5UGni7UYxW7iSM
	 Lpdwe2MAi3v55fejWYm/j059MMYCir+g0wmbrDr+vAVyGtjZkTIby/GWXpb6X5eedC
	 8OCLYRZ4HhHta7qxRapAUb9hBD3qgZMO+vWAzIVmabL666I1uOu01Nn8hnm/O4NVDf
	 rkp69DsqyVWgw==
Date: Thu, 6 Nov 2025 14:22:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Nate Karstens <nate.karstens@garmin.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
 <jacob.e.keller@intel.com>, <john.fastabend@gmail.com>,
 <linux-kernel@vger.kernel.org>, <linux@treblig.org>, <mrpre@163.com>,
 <nate.karstens@gmail.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
 <sd@queasysnail.net>, <stable@vger.kernel.org>, <tom@quantonium.net>
Subject: Re: [PATCH net v2] strparser: Fix signed/unsigned mismatch bug
Message-ID: <20251106142204.2e5f2227@kernel.org>
In-Reply-To: <20251106165117.1774787-1-nate.karstens@garmin.com>
References: <20251106163623.1772347-1-nate.karstens@garmin.com>
	<20251106165117.1774787-1-nate.karstens@garmin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Nov 2025 10:51:17 -0600 Nate Karstens wrote:
> CONFIDENTIALITY NOTICE: This email and any attachments are for the
> sole use of the intended recipient(s) and contain information that
> may be Garmin confidential and/or Garmin legally privileged. If you
> have received this email in error, please notify the sender by reply
> email and delete the message. Any disclosure, copying, distribution
> or use of this communication (including attachments) by someone other
> than the intended recipient is prohibited. Thank you.

This notice prevents us from doing anything with the patch.

Also please do _not_ send the patches in reply to existing threads.

