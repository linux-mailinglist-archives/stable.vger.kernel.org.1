Return-Path: <stable+bounces-244914-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iK4eD1Lb/mnfxQAAu9opvQ
	(envelope-from <stable+bounces-244914-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 08:59:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8A794FE5CD
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 08:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 230A630090BC
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 06:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E9BD33D6D6;
	Sat,  9 May 2026 06:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SxvwGLS7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604CC1EE01A
	for <stable@vger.kernel.org>; Sat,  9 May 2026 06:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778309941; cv=pass; b=MeaVZndyh1eu8fE7RUzssBDtdwcGzlIvq0Zr3DfTZ4NjGzaPTLO0Ew4+avsNcxT32qGI0jSgDi1QrtWmEbwlcShdfseqbGhMr9rlJAn+zPsuwPruZtmiwZB/rEA2ZJtWFHbcqLSBql/gYIhtbLUllhZJG17KIFN/H4BlRBPCz+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778309941; c=relaxed/simple;
	bh=Iesy03fy3D5hzUgxS6UMqe/aNPanV+wNGp+mdEaII4A=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=CnSQT1md3uyRq28twMoxSyRbG5lSBSH1hoFWh7BphTrRinnEGm3fovGh1Y3ZWOB+8Q+LSHZnxxl5N3mIrqo0hZ7+ERR0YqSYxxAqf0dCWQApqbIaFMmT0AXXWSMw+7rc7MEZOSy5jF1s+PQdQt7bjY4HOfD62/cbH7eX9gMy1R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SxvwGLS7; arc=pass smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-65c0891f4e9so4328039a12.1
        for <stable@vger.kernel.org>; Fri, 08 May 2026 23:58:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778309938; cv=none;
        d=google.com; s=arc-20240605;
        b=lsT3lhZ1r/5Vb12tFhwmkzp7zyZ6Q81TWckM53DoMdecSGxb+G9erYqUg5R6ehz5iI
         jSQfMqU/X3IziYTLH+Lrd6TJUcJeFaSOhDwUbIrHiZ6LJUJerOiAEMYfthYV9cJWjmVO
         tei3p4zz4LHHKK62/x0mPD5CxS4MWn/VYyOXfJWPyDSebZf8p7eD0YZSIacV46jBeYd/
         rk29wGbR3Na9PAvZ7QUn7sQZk7m2SI7BQmHWrE8hlZzgg8CE8xXhPI56NalUJH+MyX4y
         eeCLG4AO7fVeZ1qaH4476W1xhBbXOLhjRnhQey2AnP/qyQU973bCZlJb2N5GPAtU1Sj5
         NDzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=E3ZzpIcBog2zjAykMMkyaeEdu/UE5HLcjw3UeNdWEM4=;
        fh=iDburcf2YKIIuSKKPZeUyjekkjSqBJEHaoZY5VzJCqY=;
        b=d+7bpHio1Nts4U+U71wifehCSYb5eEAUgB1Kq2sDbHeCT+pVHCmzsYTmcK5gBXR/xD
         M1G7lUv1zWEojDrvcW6qTVN24jPdb62QJ/cn4YhVDbRgM6ob9TXFvhPCAB/G9EQBHl7I
         DfbnsLDUu3Hfw/vOfdrqA9jCoyciKVqN4Jd3rJhHuFNPXM2wxacSwlx/0LOiu7fbAT/t
         JrnUo8yhqey68c6YQPI1ERm1HWjBMl05kLZqfzjcZla2/JZ7M9uYDGMsd6nbCpZKAI4+
         k1i4wVGiuJHGAfXKFTfOM66/IjieTxE+7fu8owU71FVLjDPrwbPHNhVwd32TbrMYdctc
         Bj0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778309938; x=1778914738; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=E3ZzpIcBog2zjAykMMkyaeEdu/UE5HLcjw3UeNdWEM4=;
        b=SxvwGLS7H0Ckvvu1KPV7bO5L0Lg3aGFSD2QBbZFMWGj4ZWrB0GaoZPFOdvxSI/2WcN
         Xj2SrJV0dwz6aZDHaXAM9H3PoYrpjl9/AlvStsyu0dPLBGu2GLE3iEB0OjSFxOMso3Y3
         4uyAb/+IdrhXQE22WVyAbeT+j67E6Paxx/wBwmWqe3ZF0CtlBb6zLaRhQXfCalR+R89+
         znLDuXLJU4KHplUVdEl86QMwmaheRPm24ryGCpBXsFVjKXvYzU2u35UTbKmOyIxVm+ij
         8pce5H5IgUZM5VUvsahgz/vxWPSinWKeEX/3A09NQNB1tLf2TrTQKykwm5iLHa/HttEX
         rSDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778309938; x=1778914738;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3ZzpIcBog2zjAykMMkyaeEdu/UE5HLcjw3UeNdWEM4=;
        b=haltJ0g9tTymxDVf7ZS2mSfjkmq+CdBpdTYrbVbM5+w+0gQiauOGsVzhU566CtHaYR
         wOXKh2wBRb3vMlPaoElDCCLiBQ6UeWmK7lSAy9z5M7deDcQUB2z/7LcvibNSPZyiaYyM
         K0s+KjCKr++Kok6fBw1KE/9qAAANX9xHskQeRUgj1//Ao/KKUAa6S+clYVgeXGbw4x2r
         KchWYyo+pL3uZ27P/MGb99e+FiT8aSAC5mF7STM4yyW3ZUv4G4suQ0uQ6sbzSBo6XMKK
         0pVYXi5BRTzL7q0FSj2xCCItlJCQEfNMV8+pBinxAdTM3MlJCCYBsfxpbS8HnVVrMsvp
         0UgA==
X-Forwarded-Encrypted: i=1; AFNElJ+DA0lzj2/Vf7TYMwD4gfpiOT5jaCPKGzWl7p58jIuUSP8ND8GjpCgZLJ+xX2Pm/kqSC0Agj48=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfVUm3Obpjlv/Vt1usREXPkD2pOaM8Twy9q4d1+ekoi32kdA1n
	gzLEfDaL7FlK+EI//BGgJ1134aw4xnA2MOm/aOjUo3s8xYMOIalSkCqA+TAKrkr3rgPdxoa+o5c
	nLOS92PQIYkr++8P6NJI2DBRbcZxE/0w=
X-Gm-Gg: Acq92OHH3TCKkJTSuSRIrMbuumq0kCtg9gCkKuVe/gR2hciMFhiuvsAXDDOUk72fojX
	rhRvT1hA2mZlkgk8sfccshtkCqf1MQ2OkWuyZnWxYUARv2LUMAe17OsmWWeAfIP4haBpVi2kWNh
	3aHNRovvP9eko5259GklwnkaryafJw9B6Un8uvXrRbop//puWYZRUlUleG3vGr6ibF8e/YLT0CM
	yiofsE4R6cwnviV7OKf0jz2JaMXA+TOdvCvle4yzmlRP8ZybklQeRwUvkV5XZxs/uAmDEcW66eB
	94jx1PNhCeWNI3crmR2HP/Nyo03E238Mk5HNw0Xv
X-Received: by 2002:a05:6402:e94:b0:671:8ba1:e8ab with SMTP id
 4fb4d7f45d1cf-67d63d7ef4amr7643931a12.1.1778309937518; Fri, 08 May 2026
 23:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?5pyo5Y+j55KD6Z+z?= <kiguchi.r.sec@gmail.com>
Date: Sat, 9 May 2026 15:58:45 +0900
X-Gm-Features: AVHnY4Jm_ebRILmB2uHfdYlz90IiPkPJ0DPNDTLz42rzdOq3SYR5j5oNNsVE12g
Message-ID: <CAKs+XO1WXrv4jvNuEyMxu-iP9E-fifJLwOZ1nJynDjpvfn2n=g@mail.gmail.com>
Subject: [PATCH] staging: vme_user: validate slave window size against buffer size
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, security@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D8A794FE5CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244914-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kiguchirsec@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

This patch addresses the OOB read/write reported earlier
in the security@kernel.org thread (now handled publicly per
Greg's and Willy's guidance).

Tested on Linux 7.1.0-rc2 with KASAN; all three reproducers
fail with -EINVAL after applying this patch and produce no
KASAN splat.

From 506ecfc9b8608fb3a56477b8fd205238a1bf66ff Mon Sep 17 00:00:00 2001
From: Rion Kiguchi <kiguchi.r.sec@gmail.com>
Date: Sat, 9 May 2026 15:38:33 +0900
Subject: [PATCH] staging: vme_user: validate slave window size against buffer
 size

The VME_SET_SLAVE ioctl in drivers/staging/vme_user/vme_user.c accepts
a user-controlled slave.size and forwards it to vme_slave_set() without
comparing it against image[minor].size_buf. The slave-image kernel
buffer is allocated at probe time with a fixed size of PCI_BUF_SIZE
(0x20000 / 128 KiB), but the configured VME window size can be made
much larger via the ioctl.

The subsequent read() / write() handlers (vme_user_read /
vme_user_write) clamp the I/O range against vme_get_size() (the
configured window size, attacker-controlled) but never consult
size_buf. The slave I/O paths buffer_to_user() and buffer_from_user()
then index image[minor].kern_buf with *ppos values up to
image_size - 1, well beyond the actual allocation.

Result: a local user with read/write access to /dev/bus/vme/s* can
trigger out-of-bounds read and write of the kernel slab adjacent to
the slave-image buffer.

Fix: reject slave.size > size_buf in the VME_SET_SLAVE handler. Also
add defensive bounds checks against size_buf in buffer_to_user() and
buffer_from_user() so that the I/O paths cannot exceed the
allocation even if a future ioctl path forgets to validate.

Reported-by: Pochix1103 <kiguchi.r.sec@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Rion Kiguchi <kiguchi.r.sec@gmail.com>
---
 drivers/staging/vme_user/vme_user.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_user.c
b/drivers/staging/vme_user/vme_user.c
index 11e25c2f6..41b8d5b51 100644
--- a/drivers/staging/vme_user/vme_user.c
+++ b/drivers/staging/vme_user/vme_user.c
@@ -156,6 +156,11 @@ static ssize_t buffer_to_user(unsigned int minor,
char __user *buf,
 {
  void *image_ptr;

+ if (*ppos < 0 || (u64)*ppos >= image[minor].size_buf ||
+     count > image[minor].size_buf - (u64)*ppos) {
+ pr_warn_ratelimited("%s: out-of-bounds access\n", __func__);
+ return -EINVAL;
+ }
  image_ptr = image[minor].kern_buf + *ppos;
  if (copy_to_user(buf, image_ptr, (unsigned long)count))
  return -EFAULT;
@@ -168,6 +173,11 @@ static ssize_t buffer_from_user(unsigned int
minor, const char __user *buf,
 {
  void *image_ptr;

+ if (*ppos < 0 || (u64)*ppos >= image[minor].size_buf ||
+     count > image[minor].size_buf - (u64)*ppos) {
+ pr_warn_ratelimited("%s: out-of-bounds access\n", __func__);
+ return -EINVAL;
+ }
  image_ptr = image[minor].kern_buf + *ppos;
  if (copy_from_user(image_ptr, buf, (unsigned long)count))
  return -EFAULT;
@@ -394,6 +404,14 @@ static int vme_user_ioctl(struct inode *inode,
struct file *file,
  return -EFAULT;
  }

+ /*
+ * Reject window sizes larger than the kernel buffer
+ * allocated at probe time, otherwise subsequent
+ * read/write would access memory beyond kern_buf.
+ */
+ if (slave.size > image[minor].size_buf)
+ return -EINVAL;
+
  /* XXX We do not want to push aspace, cycle and width
  * to userspace as they are
  */
@@ -401,7 +419,6 @@ static int vme_user_ioctl(struct inode *inode,
struct file *file,
  slave.enable, slave.vme_addr, slave.size,
  image[minor].pci_buf, slave.aspace,
  slave.cycle);
-
  break;
  }
  break;
-- 
2.43.0

