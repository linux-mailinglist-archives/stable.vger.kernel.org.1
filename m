Return-Path: <stable+bounces-244797-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +L2iFWUW/mkTmwAAu9opvQ
	(envelope-from <stable+bounces-244797-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 18:59:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A054F9A67
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 18:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 951F2302800B
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 16:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE83B40FD96;
	Fri,  8 May 2026 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="h6NKmhHu"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99E740627E
	for <stable@vger.kernel.org>; Fri,  8 May 2026 16:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778259549; cv=none; b=qiVoOucT45anqgB1KaXbQDDGP4baD0uXFJZge7hiTObJ5sD+aSlrMdpgKZEs+5/hwRqh+d1HPA0XgQXG+1Ja1QnO2wSNan3L2qTvRuO3DRTRhx5B7F29a3zPjpqUH93TTrLWrNdY7hA5UxpKzfwFue6s6G4YRdPVosqFsb5Jieg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778259549; c=relaxed/simple;
	bh=o2dnZnuH1mqiYKQPxxm0LpRt30YvSb3Wk+MFaRrg+Cw=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=p4XO4CDDw0nrTafnxWtTIQZRx4kduYTr3iHk0GcSuDSMBNiBCZyxR1jWzKOJ4bxqT8ejqSY54j7b886WpvlHahcav1XkaveMLCDk9wXKpLP7ZpdTAVdWDeRnXlPyf+WWTDwA0lpV8rt4JLi5yS7j0BlZFtEFjMmjfVRmgUNvQrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=h6NKmhHu; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2f7020a928eso3054064eec.1
        for <stable@vger.kernel.org>; Fri, 08 May 2026 09:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778259546; x=1778864346; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mbyk03iPgG5MOWcP8ihpYZ6zh1RAfKBHbT6WA/Wnmjw=;
        b=h6NKmhHuIziP0YncdEoSCVSk7A6y4kGGg68NjcKVy8rIT6L0Lt+pxjWMGTfDqE8gBb
         y97flaOhwVFJjmcPHRp0S0jQ+eZjw9lDgn9TS/T33dLxoMbr1Q+HHaaGVRyMJuTlt9ak
         mFmT4Vw7JuiJQoKuHLLPonDYPpeWTLkyt8HOYjbFiYEz7DtVaS95qxuvTVWZBmAiMd6j
         TsW3tbzPyNbI6kFZqzesHHiXEXFzes1IOM6r+S09kXoAJuhJIyFrfbYJrQQPBqpCLtMf
         Nmv78QL/xBMIUZ0Sy6iu1ntvn8qAHApQoOMhoysH/adQ/TZ516C7+sAHoZ932tOIc7PT
         XUew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778259546; x=1778864346;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mbyk03iPgG5MOWcP8ihpYZ6zh1RAfKBHbT6WA/Wnmjw=;
        b=B5qafi9+xVK6dRyi95Dea2bqNwoJMfeOsYiQKdm6pGT/2AMrxnVhIWwZxcSThSKvFJ
         ylS4u8Yt71KdjkceESmFHic80Hh1aNVPzGq4yxgsf1JzJQa3iMMSaVLCIAzg5YXiao56
         77UhtRnMoOnF8n4I7fA4AYkM6PRfbu0zm/5Zxu0F2Yyaw1Ml8TK7uBQ4siwQ+d0Mlplt
         fxol1tc2auDNm+InWCNYQRDeY4FIh3B7aGoHl1f8ePHNZcKqB0B0LLCV2qtBiWbwkucm
         Tj1f8lCF3LpXMAt9Q7DnXw4/92V+utvFePh8IE8jC5gEsvOwqEF6izgWfh8IOCk2zySy
         R2SA==
X-Forwarded-Encrypted: i=1; AFNElJ+P9y+Ivq4cxH++AO7elsRRDK/WgCU80qSfvwqNNX9fJRgGM7UUh3Uox4R8gRtBSCcZkYzE7C0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ZTazdsfa+r89hezbIqqtNh70uNqSCpba+q7/ELJHjDxGYUxh
	GFJSm3ZL9DevrJq2pgf96cdSazVgiPnfE2351tREoN2i6SCYTLb+hmemMKbFwLnMNrg=
X-Gm-Gg: Acq92OGSYJvA+szNR5uNte3rpow/ocraaZNfUzMauzw63khGB1z9Ym1a2z7nyS8ZF13
	q2pZbDCtEzypIlmTKYAkuWehF9PsyDhcgNGXS/wDpPviTtp+5YmslbX7lPRrkFu6ZT3xNbvglvC
	FbAnQaTEo0fxwNpjMbPgkl0l4c33MyRCidw6EMhCnRZYDyF3CP4iO8F0O9pWqSYgyiM3ktVCPCj
	e6Kl2VzJ3YzcyTrvryjaBhocdg9PJ5SGBnIiU4NyK/a3PH86Xu38KXXs2ZveLpj65hAtbcykmV6
	kY+RaSIcPN1L4JkIvvw1aAWniSS0MeN1EjSIHvp+MXUqVWrnhvVYApowW1ay9LqCR0S7oJqxhQ1
	9IKxcH9P182rJdv8/RKh23WZurwq+ap5ShiNw97JTuh94z4CwZ4M/LIb7bi5nurn5/KUlit2Lzi
	M9W27oKyOSssFVJFQz
X-Received: by 2002:a05:7300:bc1a:b0:2c1:3f85:747 with SMTP id 5a478bee46e88-2f54a87e870mr6053713eec.21.1778259545905;
        Fri, 08 May 2026 09:59:05 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8884752ccsm2857305eec.17.2026.05.08.09.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 09:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable/linux-6.1.y: (build) error: Bad exit status from
 /var/tmp/rpm-tmp.5xptAa (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 08 May 2026 16:59:04 -0000
Message-ID: <177825954438.4269.13477415764062588557@997d03828cfd>
X-Rspamd-Queue-Id: A1A054F9A67
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-244797-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,lists.linux.dev:replyto]
X-Rspamd-Action: no action





Hello,

New build issue found on stable/linux-6.1.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.5xptAa (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:71) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:a46661cfb7c3183a33f877410cc5fb235ef296f5
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
- commit HEAD:  ad16b162f21d970235ced0c7e36e960c227317e8
- tags: v6.1.172

Please include the KernelCI tag when submitting a fix:

Reported-by: kernelci.org bot <bot@kernelci.org>


Log excerpt:
=====================================================
# /tmp/kci/artifacts/fragments/0.config -> /tmp/kci/artifacts/build/0.config
# /tmp/kci/artifacts/fragments/1.config -> /tmp/kci/artifacts/build/1.config
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- x86_64_defconfig
scripts/kconfig/merge_config.sh -m -O /tmp/kci/artifacts/build /tmp/kci/artifacts/build/.config /tmp/kci/artifacts/build/0.config /tmp/kci/artifacts/build/1.config
Using /tmp/kci/artifacts/build/.config as base
Merging /tmp/kci/artifacts/build/0.config
Value of CONFIG_ENA_ETHERNET is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_ENA_ETHERNET is not set
New value: CONFIG_ENA_ETHERNET=y
Value of CONFIG_BLK_DEV_NVME is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_BLK_DEV_NVME is not set
New value: CONFIG_BLK_DEV_NVME=y
Value of CONFIG_XFS_FS is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_XFS_FS is not set
New value: CONFIG_XFS_FS=y
Merging /tmp/kci/artifacts/build/1.config
#
# merged configuration written to /tmp/kci/artifacts/build/.config (needs make)
#
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- olddefconfig
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu-
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- bzImage
rm -rf /tmp/kci/artifacts/build/modinstall
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build INSTALL_MOD_STRIP=1 INSTALL_MOD_PATH=/tmp/kci/artifacts/build/modinstall ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- modules_install
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1778256915 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- binrpm-pkg
Building target platforms: x86_64-linux
Building for target x86_64-linux
warning: line 22: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.OAevHo
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.5xptAa
+ umask 022
+ cd ./kernel-6.1.172-build
+ /usr/bin/rm -rf ./kernel-6.1.172-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-6.1.172-build
+ /usr/bin/mkdir ./kernel-6.1.172-build/BUILDROOT
+ mkdir -p ./kernel-6.1.172-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:747: include/config/auto.conf: No such file or directory
+ cp ./kernel-6.1.172-build/BUILDROOT/boot/vmlinuz-6.1.172
cp: missing destination file operand after './kernel-6.1.172-build/BUILDROOT/boot/vmlinuz-6.1.172'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.5xptAa (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69fe073d0e4ee292cbf0fab0


#kernelci issue maestro:a46661cfb7c3183a33f877410cc5fb235ef296f5

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

