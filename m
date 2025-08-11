Return-Path: <stable+bounces-167054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF8F3B21311
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 19:25:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C25504E3A1A
	for <lists+stable@lfdr.de>; Mon, 11 Aug 2025 17:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ABD2D3EC2;
	Mon, 11 Aug 2025 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ll2i+Ebo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q9+7FIYv"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6652929BDB8;
	Mon, 11 Aug 2025 17:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754933114; cv=none; b=jV8f4+wNWc78enIhYCJod/1ODDyk+zPibjnMCmEWQz2CYO1innAlLWu2irnHyMjuf0sV8DSWI7DBWBn5kZ1A1/4z6hehfqawy4PZLAuTUnjVXC4lZKkfzBHlUpXnH3dHYbzdQNmBstmM6VneYF9+ZQZdZLgaJhezh3JmAOW31Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754933114; c=relaxed/simple;
	bh=lvhkMu0W1b5OC5e9sXMMahIDxfFt5PSt4ywN015JGAo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ju5HAEXEFVs8QJHegO/vejNm5aGUd2S3ZqYuTY2NpEUKbLmg6YVRMiel1GFEVt4PnfNiMsDdBH62AaT+CTo4vQKmRJtZTZZiSJRuzJxs7593mGy3NoKo4AS5pRDTHiG2q23LudtZpxrzIyAyXLgYBybxHLPxUyMh+Q4qdQSZYUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ll2i+Ebo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q9+7FIYv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 Aug 2025 15:58:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754933111;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eicc9bv7E8hw8eiH/Xiu7qBfBTipp6bu/QoYdC/hMDU=;
	b=Ll2i+Ebo2Lb5AOqf/R12xnnuYKrfQIn0U14py/nhpLCWtL+pmdPS7CGllxcSDbBk/kmUOR
	NCq/dOmp5gZi8iTUbL9uFfUHYQH83V5GQvNF1tVdNVFGVC/+oWkicumCD92tEEjNBaHwBr
	HqQkVSlhd7WTodiNlfwkKRAlVqLc380BAkkHQ/NYErmlv2ZpvHI8OWZ4MTbvlVmV3c3LYT
	dGFgteDaxh4CVf3XcaJedAg8z6BEkLr4FmLCO6YF3BIzs6Vl5WD0vUpwr7k58ZBbcFJN5G
	vzu9Dw6uQVhLeIn/ykCNXhaPYSLoceW2bOadhA7dqnsdq3dbUzpgOGk8iIyLKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754933111;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eicc9bv7E8hw8eiH/Xiu7qBfBTipp6bu/QoYdC/hMDU=;
	b=q9+7FIYvqWxZNaL3T+Eak4sUeZNlVfK4n4bU6jMtw1adDE02TIpjrve75IW0zrSd/YKaEV
	6QZ5aFRZClw9gTCw==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Use user_write_access_begin/_end() in
 futex_put_value()
Cc: Waiman Long <longman@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
 stable@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250811141147.322261-1-longman@redhat.com>
References: <20250811141147.322261-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175492788185.1420.501184708577751287.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     dfb36e4a8db0cd56f92d4cb445f54e85a9b40897
Gitweb:        https://git.kernel.org/tip/dfb36e4a8db0cd56f92d4cb445f54e85a9b=
40897
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Mon, 11 Aug 2025 10:11:47 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 11 Aug 2025 17:53:21 +02:00

futex: Use user_write_access_begin/_end() in futex_put_value()

Commit cec199c5e39b ("futex: Implement FUTEX2_NUMA") introduced the
futex_put_value() helper to write a value to the given user
address.

However, it uses user_read_access_begin() before the write. For
architectures that differentiate between read and write accesses, like
PowerPC, futex_put_value() fails with -EFAULT.

Fix that by using the user_write_access_begin/user_write_access_end() pair
instead.

Fixes: cec199c5e39b ("futex: Implement FUTEX2_NUMA")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/all/20250811141147.322261-1-longman@redhat.com
---
 kernel/futex/futex.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index c74eac5..2cd5709 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -319,13 +319,13 @@ static __always_inline int futex_put_value(u32 val, u32=
 __user *to)
 {
 	if (can_do_masked_user_access())
 		to =3D masked_user_access_begin(to);
-	else if (!user_read_access_begin(to, sizeof(*to)))
+	else if (!user_write_access_begin(to, sizeof(*to)))
 		return -EFAULT;
 	unsafe_put_user(val, to, Efault);
-	user_read_access_end();
+	user_write_access_end();
 	return 0;
 Efault:
-	user_read_access_end();
+	user_write_access_end();
 	return -EFAULT;
 }
=20

