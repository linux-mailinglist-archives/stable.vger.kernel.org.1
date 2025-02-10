Return-Path: <stable+bounces-114635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D34CA2F0BA
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 16:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19E37168B6A
	for <lists+stable@lfdr.de>; Mon, 10 Feb 2025 15:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20A924418F;
	Mon, 10 Feb 2025 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lrxkVKPk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F4524418D
	for <stable@vger.kernel.org>; Mon, 10 Feb 2025 15:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739199643; cv=none; b=YSdiyGxRQrBR+ZnVvHmBUxVtM3s9Eu73vHdUo+zXAwqawXz9dC3N9q4WjCygfnyruC0/+vkoIlI0UdW7NuxBY5vSfKp7NGYXozE4CxSXdCc8lP/GRu/Ihv3dB8Para7xcE03ZLSAWb5vypVKMhzNeg7Nzww/hXyr9WSJS+Jfmuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739199643; c=relaxed/simple;
	bh=uR2HXHq9yHNRGMa6IFQhhvUN5rqFz9ZwCSsO4LZYvNg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RX6MpMuPJELcdJPD4TkuY1Q80aVs83OOfUAX+PPhwtwV47/UNwY7LdTLdR5pEdgiMZFah28mtoyiILAleb4rxuGsFXaVIkkTgEGBmi1xefHuVvRm13fP9Fjm35lADNsbySS8GDhW/Qcy27Jga3e6s4a9QFkjr7fd00c1ybCQHQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=lrxkVKPk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61B19C4CED1;
	Mon, 10 Feb 2025 15:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739199642;
	bh=uR2HXHq9yHNRGMa6IFQhhvUN5rqFz9ZwCSsO4LZYvNg=;
	h=Subject:To:Cc:From:Date:From;
	b=lrxkVKPkeAfdRCBfZyTBui8doil2DAZG6IOHkDAEMbcr4vzWxnblTV+pLWrg1ToIe
	 5+2x74cz+k/mPwmxRIC4odd2AZDsoxowhN/z9KHCkPFPyoXgiNWA8t7vn35UmreZZW
	 8hGWcGgs6QiMknGYQUnI7DSW4hcFObQKb/f76OPY=
Subject: FAILED: patch "[PATCH] tpm: Change to kvalloc() in eventlog/acpi.c" failed to apply to 5.4-stable tree
To: jarkko@kernel.org,andy.liang@hpe.com,ardb@kernel.org,stefanb@linux.ibm.com,tiwai@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 10 Feb 2025 16:00:26 +0100
Message-ID: <2025021026-scribing-driven-fe23@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x a3a860bc0fd6c07332e4911cf9a238d20de90173
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025021026-scribing-driven-fe23@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a3a860bc0fd6c07332e4911cf9a238d20de90173 Mon Sep 17 00:00:00 2001
From: Jarkko Sakkinen <jarkko@kernel.org>
Date: Fri, 27 Dec 2024 17:39:09 +0200
Subject: [PATCH] tpm: Change to kvalloc() in eventlog/acpi.c

The following failure was reported on HPE ProLiant D320:

[   10.693310][    T1] tpm_tis STM0925:00: 2.0 TPM (device-id 0x3, rev-id 0)
[   10.848132][    T1] ------------[ cut here ]------------
[   10.853559][    T1] WARNING: CPU: 59 PID: 1 at mm/page_alloc.c:4727 __alloc_pages_noprof+0x2ca/0x330
[   10.862827][    T1] Modules linked in:
[   10.866671][    T1] CPU: 59 UID: 0 PID: 1 Comm: swapper/0 Not tainted 6.12.0-lp155.2.g52785e2-default #1 openSUSE Tumbleweed (unreleased) 588cd98293a7c9eba9013378d807364c088c9375
[   10.882741][    T1] Hardware name: HPE ProLiant DL320 Gen12/ProLiant DL320 Gen12, BIOS 1.20 10/28/2024
[   10.892170][    T1] RIP: 0010:__alloc_pages_noprof+0x2ca/0x330
[   10.898103][    T1] Code: 24 08 e9 4a fe ff ff e8 34 36 fa ff e9 88 fe ff ff 83 fe 0a 0f 86 b3 fd ff ff 80 3d 01 e7 ce 01 00 75 09 c6 05 f8 e6 ce 01 01 <0f> 0b 45 31 ff e9 e5 fe ff ff f7 c2 00 00 08 00 75 42 89 d9 80 e1
[   10.917750][    T1] RSP: 0000:ffffb7cf40077980 EFLAGS: 00010246
[   10.923777][    T1] RAX: 0000000000000000 RBX: 0000000000040cc0 RCX: 0000000000000000
[   10.931727][    T1] RDX: 0000000000000000 RSI: 000000000000000c RDI: 0000000000040cc0

The above transcript shows that ACPI pointed a 16 MiB buffer for the log
events because RSI maps to the 'order' parameter of __alloc_pages_noprof().
Address the bug by moving from devm_kmalloc() to devm_add_action() and
kvmalloc() and devm_add_action().

Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Cc: stable@vger.kernel.org # v2.6.16+
Fixes: 55a82ab3181b ("[PATCH] tpm: add bios measurement log")
Reported-by: Andy Liang <andy.liang@hpe.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219495
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Tested-by: Andy Liang <andy.liang@hpe.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

diff --git a/drivers/char/tpm/eventlog/acpi.c b/drivers/char/tpm/eventlog/acpi.c
index 69533d0bfb51..cf02ec646f46 100644
--- a/drivers/char/tpm/eventlog/acpi.c
+++ b/drivers/char/tpm/eventlog/acpi.c
@@ -63,6 +63,11 @@ static bool tpm_is_tpm2_log(void *bios_event_log, u64 len)
 	return n == 0;
 }
 
+static void tpm_bios_log_free(void *data)
+{
+	kvfree(data);
+}
+
 /* read binary bios log */
 int tpm_read_log_acpi(struct tpm_chip *chip)
 {
@@ -136,7 +141,7 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 	}
 
 	/* malloc EventLog space */
-	log->bios_event_log = devm_kmalloc(&chip->dev, len, GFP_KERNEL);
+	log->bios_event_log = kvmalloc(len, GFP_KERNEL);
 	if (!log->bios_event_log)
 		return -ENOMEM;
 
@@ -161,10 +166,16 @@ int tpm_read_log_acpi(struct tpm_chip *chip)
 		goto err;
 	}
 
+	ret = devm_add_action(&chip->dev, tpm_bios_log_free, log->bios_event_log);
+	if (ret) {
+		log->bios_event_log = NULL;
+		goto err;
+	}
+
 	return format;
 
 err:
-	devm_kfree(&chip->dev, log->bios_event_log);
+	tpm_bios_log_free(log->bios_event_log);
 	log->bios_event_log = NULL;
 	return ret;
 }


