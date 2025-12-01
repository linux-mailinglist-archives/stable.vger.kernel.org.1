Return-Path: <stable+bounces-197817-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A864C97000
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 12:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 191BC4E426C
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 11:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F027307AE1;
	Mon,  1 Dec 2025 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u/51CZ3a"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF10306D50;
	Mon,  1 Dec 2025 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764588610; cv=none; b=BvF97ZDr6bOuQ5QofBNWFVAWZTmBfPoaBbazSSXaJuthjIul+LF1dU9a1cIj8iO5W5O8oe12XVZBXp9FsG82gPsUIzJovDkkLKvpiXTovuTQweCpCbE41ORu2/85HYo60jjpRu+u86I0Xfk3+2GGJVQT1XrhhTA1lclT65gZUNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764588610; c=relaxed/simple;
	bh=5Ll2fVMHMP0Gt7rrSbhpRbfLxREfVeSAa70/eUsAP/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrHsWIciQU+s+FfBVmaaidYGKJShjgargkxuzw8ZmRjoyGYYoS/O4qiC4Y3dO1j9L72xEl6tiB49EBHt9YsrsiZOGpjKifrLq5HIeEBBD/Oqug7SkMabWfd3XhK0YOJzp68lmkoLfcRj2jSh0N35aXePOTnc9ygvhlXAglTGV+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u/51CZ3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1820C4CEF1;
	Mon,  1 Dec 2025 11:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764588610;
	bh=5Ll2fVMHMP0Gt7rrSbhpRbfLxREfVeSAa70/eUsAP/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u/51CZ3aqHGBIAuukfPD3PHRWNVNuMVnnrTaIoH2uPIddNGb5ALCVI4Zun+joKtI0
	 UrC8T4LY5hmjqS0Xu1awylmzQ/XEQDCALyeJhu6DHRVaNTMMuSrJQbX0GbYDmrHD7I
	 6LoMRmm3qMyt9JVEyKKdtGqDmnjvrPbOU5uRvNxs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Randall P. Embry" <rpembry@gmail.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 108/187] 9p: fix /sys/fs/9p/caches overwriting itself
Date: Mon,  1 Dec 2025 12:23:36 +0100
Message-ID: <20251201112245.137166361@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251201112241.242614045@linuxfoundation.org>
References: <20251201112241.242614045@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Randall P. Embry <rpembry@gmail.com>

[ Upstream commit 86db0c32f16c5538ddb740f54669ace8f3a1f3d7 ]

caches_show() overwrote its buffer on each iteration,
so only the last cache tag was visible in sysfs output.

Properly append with snprintf(buf + count, …).

Signed-off-by: Randall P. Embry <rpembry@gmail.com>
Message-ID: <20250926-v9fs_misc-v1-2-a8b3907fc04d@codewreck.org>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/9p/v9fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/v9fs.c b/fs/9p/v9fs.c
index 39def020a074b..b304e070139ca 100644
--- a/fs/9p/v9fs.c
+++ b/fs/9p/v9fs.c
@@ -558,7 +558,7 @@ static ssize_t caches_show(struct kobject *kobj,
 	spin_lock(&v9fs_sessionlist_lock);
 	list_for_each_entry(v9ses, &v9fs_sessionlist, slist) {
 		if (v9ses->cachetag) {
-			n = snprintf(buf, limit, "%s\n", v9ses->cachetag);
+			n = snprintf(buf + count, limit, "%s\n", v9ses->cachetag);
 			if (n < 0) {
 				count = n;
 				break;
-- 
2.51.0




