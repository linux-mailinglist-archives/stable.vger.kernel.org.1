Return-Path: <stable+bounces-241875-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFywLpXy8WmElwEAu9opvQ
	(envelope-from <stable+bounces-241875-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:59:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F23493CDE
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 13:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7868E3004686
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 11:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56D202F5328;
	Wed, 29 Apr 2026 11:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="dIarXD+X"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF33D1A6807
	for <stable@vger.kernel.org>; Wed, 29 Apr 2026 11:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777463948; cv=none; b=Ngz+PxuHQo+LGKQTVYF+XXNokbTBzoJei2lGaQta8mcmpGzmNCbO+yKMSnWp5Nj+9D35yi4M6KUTG7fhLBXhifFe8cq4HIZIbfOhM47z8yn1aL2J60Vlvxo2XRIwsKUTiECutu6bWDpCZpgk/IwpSQx5NeUCYLY3+DoOQYJQpYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777463948; c=relaxed/simple;
	bh=S9mRGcV/7Wf6FJrGaqZo3jB8lyUf2MO45aoTlX4+Mv8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=HtIcA6mcIPenhtw5m4F40iHkyFz+S8f10ildja8YxFI1n0mmmMVlZYqPngUFcv5y8VTN7wIDYsxKc8pIMOevXBDqPpgcq+aMahM4hKL70BFPDrZfbI1K37WW9K42SwPP2J8qIRydv2dbzRuQXhFM7kdqhPtYmT8tGW5carnFspU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=dIarXD+X; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2ecf9e398f4so6132440eec.1
        for <stable@vger.kernel.org>; Wed, 29 Apr 2026 04:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1777463946; x=1778068746; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEAQe/h7jSAB/RjyWv3OoIy3HnuCeq73gqAXZDCdZJk=;
        b=dIarXD+XAHN0mC3B1s/5gKcVCAj+RR4bfRgqC+l+cwTfs4A1sCWuRQht1CBuP2PmVU
         xZOYb+5cwIgHp8Z1mOYRoYkeSJysXZYOVDdr/daChzaT3Qwdjw0w5vzoKlNWOd0SGORa
         DIMTK5Kbzrv4xS4Kry/rsknBKSi1qe4qUEk0F0Jr4KwDAhdy4AIWtyvApR2zVmZsjl5B
         anMgl+ac9alKpNco/uDHdFbblrmGG8YFmziTj6YptvVoTqev5h1DtH/mnTMNoIFAVIBE
         hKBub2aybe4a7GF5uUPs6jPyRgfH0qpyd4l9bjYXKi77Vz8ykTnod4txuAe4yoxpwWRx
         PBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777463946; x=1778068746;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dEAQe/h7jSAB/RjyWv3OoIy3HnuCeq73gqAXZDCdZJk=;
        b=fGzva5mpvge7aHJsPi//ijhO00jMLt/cAfSnv3oF7tWxcCCSN1p+GDiYBcvZT3XIg2
         dFVtbKJsWtCRu7qjgz96dDVPX2C3iU15wsuoe/IiE/maKoXfgR0wX6yHF6GKO/GbF2gG
         WYUUk0AgA6/8yndtTjVM3fg79POGNiPIepXpjW5jJermNQ3Afsfyho4Y0ga9ZjBrOZBn
         CWkQdfGwVQcmLkuiYB6XBlSDcUaNIsxn87KrOnwgdOL9MBgz0Hp0qRaz2XHrgWmcM7b1
         eqBfqdH0GVwZNygkDdsu54eadm0ULRhKKDrHw2Vskq3wRRT7t6B6aUBxxDaXHfUAQHV2
         u1rw==
X-Forwarded-Encrypted: i=1; AFNElJ99CLbje9MJQJ4/JVCLkOup9fVlAs5ExpCJf5nP3+ZZyxwLTExCf+He+njDL6P0KdSoaNa05GI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6/xmYUHLDttGOpCV+M9nsCSp/vSGY62O8nzc2SEFaphaU1na
	7j8QtN+mOu+18S0TZE+Wugb9xmurI+j8wCGF/qPV6tfHlfsAW4nUlGVDX9qIytTtkCM=
X-Gm-Gg: AeBDieuwbVIB0pVUNadQ5FQmj5aQnVhkU8cBKCeH/NTVWOA6JWy83hf7S40iCxEY2Ct
	xLEXANf+giu+9sKQcWjfMf7SGuz6M1OnugAs2sbfdseHGGEKw04qEwmovvi5UZYbS+KpCBSjw5x
	YDUhh/yOcC2NA9bE+BV6AvPGZokbbatGQ5B3O4VMedKCjyZ4qe9n/ZJ8mIHXr6LntgjYCTAmBL2
	7asB93h75Udf/zrvJTxN7m6wrrWiPk13S2iJyNBCZnVlpTSa+51wzLALsqm4+//71sAU/uF8i68
	b3bNZKVAzmGjftT0ehNGvssAOwsaoYh0zHP2ZDbVON1qKteICll2c/AD1FgWAJow58Qvzok+bhR
	//fFlDW6CK9o5DGTAdfWSnhaiGpTThEtKjdg50bplM3vmSqLKykQ8K2E4D5IQnHhkEm3J5tVpe4
	i7wKonaedJ+ft6Z8HXbmoG7OCp0VA+uiBpHaO5sQ==
X-Received: by 2002:a05:7300:7255:b0:2ed:e12:3771 with SMTP id 5a478bee46e88-2ed1991b2a9mr1521902eec.33.1777463945730;
        Wed, 29 Apr 2026 04:59:05 -0700 (PDT)
Received: from 7f5f57871823 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed1bf6d52fsm1845399eec.4.2026.04.29.04.59.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 04:59:04 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [REGRESSION] stable-rc/linux-7.0.y: (build) in binrpm-pkg
 (/tmp/kci/linux/scripts/Makefile.package:75) [logspe...
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: gus@collabora.com, stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Wed, 29 Apr 2026 11:59:04 -0000
Message-ID: <177746394435.2212.14228042765433357994@7f5f57871823>
X-Rspamd-Queue-Id: D0F23493CDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-241875-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lists.linux.dev:replyto]





Hello,

New build issue found on stable-rc/linux-7.0.y:

---
 in binrpm-pkg (/tmp/kci/linux/scripts/Makefile.package:75) [logspec:kbuild,kbuild.other]
---

- dashboard: https://d.kernelci.org/i/maestro:4fdb5583057fedafa816917f15e40cf6a4866b6b
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
- commit HEAD:  bff90486aa66dbad83a0777f3c17e34fcf26a3e5
- tags: v7.0.2

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
Value of CONFIG_BLK_DEV_NVME is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_BLK_DEV_NVME is not set
New value: CONFIG_BLK_DEV_NVME=y
Value of CONFIG_ENA_ETHERNET is redefined by fragment /tmp/kci/artifacts/build/0.config:
Previous value: # CONFIG_ENA_ETHERNET is not set
New value: CONFIG_ENA_ETHERNET=y
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
tar --sort=name --owner=tuxmake:1000 --group=tuxmake:1000 --mtime=@1777462488 --clamp-mtime -caf /tmp/kci/artifacts/build/modules.tar.xz -C /tmp/kci/artifacts/build/modinstall lib
make --silent --keep-going --jobs=8 O=/tmp/kci/artifacts/build ARCH=x86_64 SRCARCH=x86 CROSS_COMPILE=x86_64-linux-gnu- binrpm-pkg
/bin/sh: 1: rpmbuild: not found

=====================================================


# Builds where the incident occurred:

## x86_64_defconfig+aws-ec2 on (x86_64):
- compiler: gcc-14
- config: None
- dashboard: https://d.kernelci.org/build/maestro:69f1ec5907f3fa55982d9808


#kernelci issue maestro:4fdb5583057fedafa816917f15e40cf6a4866b6b

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

