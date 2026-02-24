Return-Path: <stable+bounces-218026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCwIGWc7nmkZUQQAu9opvQ
	(envelope-from <stable+bounces-218026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:59:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D0518E379
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 00:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3301E30574B6
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 23:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E32A363C55;
	Tue, 24 Feb 2026 23:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="wVe6nR7X"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f194.google.com (mail-dy1-f194.google.com [74.125.82.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6861D9A66
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771977548; cv=none; b=azLMidUGobPVa6tejnxKaQiKLp53KyYq8eQynn0vhObFMyeYO89EjgJ9O03xKi3YnNJ76vqt2TC28q8ZGASFmxC+5MQVq1JtT7SdFIKDr0x3zfbTMm3NJEZwezVV+NhCaFQ7/JVvcbMU0QcoTke220G1eGOCtuEy/Sx8iaM3Agc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771977548; c=relaxed/simple;
	bh=d0VVE5m0/OhK26s0awJou3EIIJdV91/z/pw79JTPQXo=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=EywHa1dzAnlqJZBPx6TPmDs+e08APvjkoqapB+Exuw/MextEqOLeBQajkt558dmJw86N8WdHMVrNxm8v3sg8SWC6bzXz8JLtG6efkp2gwu23ck/HsP8DCIBKYprp6MWnoUz6niMm593nFFfwKOuyqc/whIXEm+lE3OYD4kdLxes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=wVe6nR7X; arc=none smtp.client-ip=74.125.82.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f194.google.com with SMTP id 5a478bee46e88-2b6b0500e06so7872607eec.1
        for <stable@vger.kernel.org>; Tue, 24 Feb 2026 15:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1771977547; x=1772582347; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oEwU70fd7WSELWnXeUxq+U5r7S3wdDSieIdgJbTqLs=;
        b=wVe6nR7X85lIXwx+HypDSzaS8pVt52fy4FvsNwfqsuFTJ8kINYfAXtoYjPxlPON+2K
         hkcAL6Uk1mYd/U7i4kVTGWCe2Ocx5yeLDIbIkbmjWJ8P0exbQk5fVFCgvukhwa/wn9EU
         YjQYypo3LyqDEe1fxVwLcwE3cPBUpnjcrLzzoQcdHpSm4DSD5J1iOpAf/SXhZvshCTaL
         a7k7JjKj/N4T4UuqZKCqJaEQ2tm/fTA6CghOznTfqEEpETFuW/UtPAy+wb/wFK7q6v/6
         bX705d/Eg1lel/6HpUDzIm38iKxkRUKQLB/tBigJjJL/XtxsL6duJapfAsyrKKAWs/B0
         7TEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771977547; x=1772582347;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0oEwU70fd7WSELWnXeUxq+U5r7S3wdDSieIdgJbTqLs=;
        b=uUkKXiuqZeZo+x5v81ZECmS1UwJX0Ao7qQTQItn0F6jTvVcn208PgSbm19LU6SZGoK
         jIxrgeGkgaX+ajlzQkOlmHYlIbr22h3mvhqT+w3HPTLz6DmiJx41ouqVKx24vNtLTfPy
         jsW9YGfQF7yQ3ZPngdGCb6QO5P1EYRxuRayTQ1CEJnDI9IjXxLRADG0oekWe04ddXX3J
         L9jzvgKTuZ0fKjCcfsUxgu1u73WrS8AHVxIo2zNpfiKla3Q6a1YrJn7QlggZ/k1yfyV7
         9Bu5uMVx+hvE/rWTz40zjs3Srkyp0Hi4HiGq4PX7ZtHYIzHSbyXjtdfvvE6fpHuzX1l7
         kXzw==
X-Forwarded-Encrypted: i=1; AJvYcCUztSK6I5s1vloQSlEFpVC1WLcI7v4pbuJ71Hk7/vtvos2qgL7abN+QkAiX3R2rqOl4baPCDV8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVtMKouKq9D4Jqhr8ezdIeTaFFX4WMh1MvQwPqFKC0Du2bNb3O
	vYqvnfJpHMVLv3hHZJTduEcotE40eYnsyouYtDE7cWwo9O+fDNXu8Jr6A5Tr0XwzFvSeb32z0Gw
	N/uy2Y+c=
X-Gm-Gg: ATEYQzx/KtR06XPLDS5Gs7wslF4RbwInyLnV3iyLrKJyoq8tNhQl87jwbC3A2ymVqka
	vXRTlgRb5oSb5/TR9YKyG5CBmwyVSe4uc1KeQgws4SsSEPYKME7NIA2sxR4i9fNxAgFSSTl2pT3
	4JQM2WL8p6KLAsNXrWKmTQed+a7HZRWqBylxtvByxAJxTn9AW7qNAAG8x2nr2IoewAy0oXEUfef
	6wXVAzXl7fIsDKydg50IUBPATB7zQZWF/wjsNvaHmMGndVfQ34j3YDbnqopaYA4pdimqXytzFfn
	TT3L7cjJ83Wta8rTFp86rFiUPvhqPYAKlcmDbHuHkirmIhNaJoAevsB9yx3k8wRflf2vIKMQw2u
	U650OVKBLXOZntLvS3vLThziYyMnPLtwYgJiEynetoMMS46aFtFKLiFTObgZPsaWulmeWyXiodZ
	I2nYROqng2fcKdM4p9
X-Received: by 2002:a05:693c:25c7:b0:2ba:6978:2b4 with SMTP id 5a478bee46e88-2bd7bd240c3mr6136941eec.20.1771977546761;
        Tue, 24 Feb 2026 15:59:06 -0800 (PST)
Received: from d14e337afe00 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bd7dbe8198sm7716185eec.22.2026.02.24.15.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 15:59:06 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: 
 =?utf-8?q?=5BREGRESSION=5D_stable-rc/linux-6=2E12=2Ey=3A_=28build=29_implici?=
 =?utf-8?q?t_declaration_of_function_=E2=80=98ata=5Fport=5Feh=5Fscheduled?=
 =?utf-8?q?=E2=80=99=3B_did_you_=2E=2E=2E?=
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 24 Feb 2026 23:59:06 -0000
Message-ID: <177197754579.2557.9601921111579196570@d14e337afe00>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://files.kernelci.org/kbuild-gcc-14-arm64-nfsboot-699e30ab1f24bb69463778c6/.config];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-218026-lists,stable=lfdr.de];
	URIBL_MULTI_FAIL(0.00)[linux.dev:server fail,kernelci-org.20230601.gappssmtp.com:server fail,sea.lore.kernel.org:server fail,lists.linux.dev:server fail,kernelci.org:server fail];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kernelci.org:url,kernelci.org:email]
X-Rspamd-Queue-Id: E8D0518E379
X-Rspamd-Action: no action





Hello,

New build issue found on stable-rc/linux-6.12.y:

---
 implicit declaration of function ‘ata_port_eh_scheduled’; did you mean ‘ata_port_schedule_eh’? [-Wimplicit-function-declaration] in drivers/ata/libata-scsi.o (drivers/ata/libata-scsi.c) [logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:43ccb2d4b2d4db78bc3984bf4140df5b8c738665
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  10fde7454a72064486a5b75cbb1635da42004473


Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
drivers/ata/libata-scsi.c:1689:20: error: implicit declaration of function ‘ata_port_eh_scheduled’; did you mean ‘ata_port_schedule_eh’? [-Wimplicit-function-declaration]
 1689 |         if (qc && !ata_port_eh_scheduled(ap)) {
      |                    ^~~~~~~~~~~~~~~~~~~~~
      |                    ata_port_schedule_eh
  CC      fs/ext4/mmp.o

=====================================================


# Builds where the incident occurred:

## defconfig+arm64-chromebook+kcidebug+lab-setup on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-chromebook-kcidebug-699e30b61f24bb69463778d1/.config
- dashboard: https://d.kernelci.org/build/maestro:699e30b61f24bb69463778d1

## defconfig+lab-setup+kselftest on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-699e30a61f24bb69463778c3/.config
- dashboard: https://d.kernelci.org/build/maestro:699e30a61f24bb69463778c3

## defconfig+netdev+nfs-root-boot+kselftest on (arm64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm64-nfsboot-699e30ab1f24bb69463778c6/.config
- dashboard: https://d.kernelci.org/build/maestro:699e30ab1f24bb69463778c6

## multi_v5_defconfig on (arm):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm-multi_v5_defconfig-699e30971f24bb69463778b2/.config
- dashboard: https://d.kernelci.org/build/maestro:699e30971f24bb69463778b2

## vexpress_defconfig on (arm):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-arm-vexpress_defconfig-699e30a11f24bb69463778be/.config
- dashboard: https://d.kernelci.org/build/maestro:699e30a11f24bb69463778be

## x86_64_defconfig+kselftest+x86-board on (x86_64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-x86-kselftest-699e31001f24bb6946377919/.config
- dashboard: https://d.kernelci.org/build/maestro:699e31001f24bb6946377919

## x86_64_defconfig+lab-setup+x86-board+kselftest on (x86_64):
- compiler: gcc-14
- config: https://files.kernelci.org/kbuild-gcc-14-x86-699e30ef1f24bb694637790a/.config
- dashboard: https://d.kernelci.org/build/maestro:699e30ef1f24bb694637790a


#kernelci issue maestro:43ccb2d4b2d4db78bc3984bf4140df5b8c738665

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

