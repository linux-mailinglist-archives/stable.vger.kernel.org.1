Return-Path: <stable+bounces-243850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFdvHH61+Gm3zAIAu9opvQ
	(envelope-from <stable+bounces-243850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:04:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4464C05ED
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 17:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5FDCE302A4E8
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825DF379980;
	Mon,  4 May 2026 14:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="eDUoFL6K"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C5D3DF017
	for <stable@vger.kernel.org>; Mon,  4 May 2026 14:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777906750; cv=none; b=cG/khPPK5RzRelmRT96ucvDlW6R0GYmtv0yeWB1DB2GE9mKO0lw621a50u+i3T9ooaBoOezV8fTKBDShMfP1aqPOUUlWi04Zwfv6Z1ey6Cj7mJz/fOvE11DF7pgOHO1xU/nOvAcldp8aMghj0pmH/h/4q8XtdKcfSBPXYBjbQM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777906750; c=relaxed/simple;
	bh=um68YpT+kO+r1KvEtdA6Yn4gjjia5+oE4BJH8/bRQZY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=cXe5JJ7vViZjoN6xcxI4yVNBEu+vt39B6ur0dqDe7hezxG8wZM5b58nkDoleqeUzRR9NehIE2zdY0mimYt4o/etX3Wi34LGWBYFk1FnJxLW9OBKkHSXD4OKkR7WL7/v6WRgxKzTyfT4jMn9f1Z/OsjfQtQrUlxZGh8neMnfTca0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=eDUoFL6K; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-2bdcf5970cdso3109257eec.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 07:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1777906747; x=1778511547; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V8nGN9LxB+rcIqDXjfuneTkJO1ZA86q47IyeLkINBmU=;
        b=eDUoFL6KZsuIxNzZ2yx9jOeTlqj+IE1aQdLEiDymOtf2U5PgEbVfZ/YgNHjaC47Icy
         fpky0Dej2UcfdeXQ6DgauXqzUX04EdCnSBulmfQ/gHvJaUHB5GbC3Jd/KWOwlXDBQf/P
         DKFQwPFIEk00CqKCSJQY755zT6H/trM5tAqP+gITYuv71ECz4C2leHJIoLIRjuAN6cxy
         WgvYRb9Bo4frxLo0Oc7h1KmHKht5nnRQqfkq1+UVdarj1VZrf/3OwjjAO9GE93dsBdEJ
         3HGHtjSg3iDucMfSNSHYGfhPLiJLnfwt+a4bWUGRcK+T3D8RsRKu4laFmiS4w6z8LPLn
         DXaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777906747; x=1778511547;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V8nGN9LxB+rcIqDXjfuneTkJO1ZA86q47IyeLkINBmU=;
        b=dEIeNkzP2lsCGja4Hw/op0WqRHphl2tUsN+pS4me4KC8jeB69yAUh0THULdtSAd66k
         nTjVdIcUgFEtnu0FwgKA5fUn7kbN8attCSAKAKno0b0/za/fcfvnPl/pWJDw+lubXSgr
         EHD3hWiDP7OAZRSZXBUpUUZYOaZL27oB6OlOeDsNR1U5MjfHTynYwqBLZ+MaAy/iJXHn
         GeLYQdtkb/PLKDjZBSyWYDRKmhFIctRXxSBuOYZWY2GKE6ftHMy/KMadjodWFXBg43EE
         LE051zJGEVA6byNwJnHFIyEXWi6gaSTChlVXyayd9L6wKDL045bvoOkiNKE3imYKMhDY
         gyjg==
X-Forwarded-Encrypted: i=1; AFNElJ8pzDKhULclj0apjwIaCnmXIZpbDSlEWth6l0eK2RhHYo+Acoldve4AaC2FMPGS+SYMH1kfC8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5JE2KnPOJja60qpoLyqaMaXxi9qiMIQjzlYhhHbzISheBzbqF
	JQhX2nzJgG1zou/yIeGCbQez0fM+eVY39ma3iElllH5VMw9UyQFbVk1e81pvR14ADEs=
X-Gm-Gg: AeBDiesIqXj9JsN1BASKDyzRVXYv+H9AjkWsVOBsJxpYhyNHVdAE1zi/meuCRSNsbHm
	/ITQiEd0a6qtitse5gS0ZkL27qCHNjNxA/T6L5ehZqLvrtEEJujykAihE36LlpIdrqN+IKcw80g
	Jf3w52e55GhFZJaXyDvj0y8WcSQybiMLjW6B4VKcFgUNDvmX58WjLnFNUbNOcY0AZtX2jMhz3m5
	9yVD3SYsrTkumm8zweAeBkFnV9UxYcpf52MOMHH9IxSPAe75kteh+7aMUTRd5zC4+aArymsWBx+
	mgVAhDkPsEkz3YXjAgcdczS2ocK7jR6aabTDaQcVZITjgzFuGtlE1EdC3w7IEfRtE7L9JttPw+H
	2gydtIEygwuhPd7amjIyh0tJvmPv8I33K9BZWiA6y/6FVm8SwmWL+gixw6wKYamH2B9bQITTvzc
	YRV69+m2N9AgoHd33t3bj/5wcomJw=
X-Received: by 2002:a05:7300:7244:b0:2c0:df3b:ec1e with SMTP id 5a478bee46e88-2ed4f1ba5f4mr6947455eec.11.1777906747012;
        Mon, 04 May 2026 07:59:07 -0700 (PDT)
Received: from 997d03828cfd ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3b29b11fsm16392159eec.19.2026.05.04.07.59.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 07:59:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-6.1.y: (build) error: Bad exit status
 from
 /var/tmp/rpm-tmp.Ow8eEA (%install) in ...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Mon, 04 May 2026 14:59:06 -0000
Message-ID: <177790674563.2389.1436465231432800268@997d03828cfd>
X-Rspamd-Queue-Id: DD4464C05ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	TAGGED_FROM(0.00)[bounces-243850-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,kernelci.org:email,kernelci.org:dkim,kernelci.org:url,lists.linux.dev:replyto]





Hello,

New build issue found on stable-rc/linux-6.1.y:

---
 error: Bad exit status from /var/tmp/rpm-tmp.Ow8eEA (%install) in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:71) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:8b49ac3a1f33e1a346345dd26e251b271044919a
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  3706134cadc0bfcc1887b832d1305df4b09dc676


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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1777902831 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- binrpm-pkg
Building target platforms: x86_64-linux
Building for target x86_64-linux
warning: line 22: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
Executing(%mkbuilddir): /bin/sh -e /var/tmp/rpm-tmp.42u8Ue
Executing(%install): /bin/sh -e /var/tmp/rpm-tmp.Ow8eEA
+ umask 022
+ cd ./kernel-6.1.171_rc1-build
+ /usr/bin/rm -rf ./kernel-6.1.171_rc1-build/BUILDROOT
+ /usr/bin/mkdir -p ./kernel-6.1.171_rc1-build
+ /usr/bin/mkdir ./kernel-6.1.171_rc1-build/BUILDROOT
+ mkdir -p ./kernel-6.1.171_rc1-build/BUILDROOT/boot
+ make -f /tmp/kci/linux/Makefile -s image_name
/tmp/kci/linux/Makefile:747: include/config/auto.conf: No such file or directory
+ cp ./kernel-6.1.171_rc1-build/BUILDROOT/boot/vmlinuz-6.1.171-rc1
cp: missing destination file operand after './kernel-6.1.171_rc1-build/BUILDROOT/boot/vmlinuz-6.1.171-rc1'
Try 'cp --help' for more information.
error: Bad exit status from /var/tmp/rpm-tmp.Ow8eEA (%install)
RPM build warnings:
RPM build errors:

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69f893b30e4ee292cbccbab7


#kernelci issue maestro:8b49ac3a1f33e1a346345dd26e251b271044919a

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

