Return-Path: <stable+bounces-259691-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLMLD19AHmraiAkAu9opvQ
	(envelope-from <stable+bounces-259691-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 04:30:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F776273C5
	for <lists+stable@lfdr.de>; Tue, 02 Jun 2026 04:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 361B93056C38
	for <lists+stable@lfdr.de>; Tue,  2 Jun 2026 02:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00DA8364E85;
	Tue,  2 Jun 2026 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="FK8EHk8h"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9059D360EEA
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367419; cv=none; b=AEd+LozL7/nyeJaRPpSsklqUkQt6kk/2IOSnl2RcyVRYeX7m6OpiTPSMRSN8lL5lDMbXrycT2wjJNqqQzdvwlHMQpDjhm1EltqJkkPcC0kIY+mPmC8ugKbJzBbJCEZTyxR8LMOffwCm+mdwOr5djQPiCvvvBVJPI80voVKE6inY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367419; c=relaxed/simple;
	bh=DCpIUgObSMjXxyxAa6I2wzyt2hhQaS48EOqwzVvEOd0=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=N8vErdz/d7AtLYLxBY9CwVv3nzRlxZqFnny8ptS5ylG1cAz6B3RxvnJuDv9PqBTf4HbEkOsKEZ2Mb4gSQRFea42WPvRdLLg5moww0f6huH3+86h/M/cpBiskr9QoEgTqc7Xc0OOJr0ugWY6xrGHhOSgihWJrm4Hb488UbjittM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=FK8EHk8h; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-304c520fe9aso11801922eec.0
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 19:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1780367418; x=1780972218; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KuCuue2wzVcjVm3QUw5hLh4Eir999jRixsD2iHd4Ozo=;
        b=FK8EHk8hwGCR+Cb/C9hU3/TE70BLPdil+HcLeHLnvYnHFqHNTm1FSc3H6o+Afkdadx
         7XaOBCxdr87b7VeR5+82blA/xSE/D71eNfTiGRZTzQSK7LKVZ7sReDSNERBV1ZyIgbhG
         v9fMxmhdMeR3UVxHGiQDkppothqNgwi0TfvMs+UxvwzPamahrtlqo7biHBDHWQxiKDYa
         H08j89VbBNkHaQBhAVSKQknC18BJu45L6Vcr1p/8C8h+a0L1KZlL6pmY6WD8Oi1W/T/R
         EepNvg55QdkqZ95Q3UXp9489WVCf7St4gS6ItTvMQW47YFcO4QnE7AwELdt+0OQhm6eW
         1+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780367418; x=1780972218;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KuCuue2wzVcjVm3QUw5hLh4Eir999jRixsD2iHd4Ozo=;
        b=YZHw+0IEdONtc5oAWlFN8Skd0eEi1KupVDyEqnw8g6tYKgrtwAxAHfcvWqJji6Y3Ey
         MsgizKcJcUXIn0Qn3O0Zr3la6bvj8HQk4XcWDM0QNmEewfUQNVeygDK6WN8WxZZnCsry
         aEm6ahHbqxC1J67WAm1poKphdFxWZ6WvesEMmDPP+RKZIP6TICaeiOWggyHYYoSn9o1z
         2+f8xV8eH/AcMHHvwz9jtTIRiyRtSafo7fL2DmD4sGP+b86XoSqcaoX9PVl+Ai7A6YuI
         YZpD/AWRUIwNxIrmaGheDyxR5L07uuv85GaEmLqgnkdN3aj13dOjdBK+/prqeMco4A4s
         4QUQ==
X-Gm-Message-State: AOJu0Yx7f5rFwfbp7SksszOThXjz6A+7maznkyf0NfHhsKhvVwztAJvl
	DNst8qgb0WvGKLNrvW3KODsBoEFJiPsN+HVK+iJjmH1dMdpf8Axl99BAHtT02YWS1Vr1nuxUhfS
	37qY2
X-Gm-Gg: Acq92OEXqjkN10rp+w09GetfL6iCyTvZtJq7LTaoZzsDiHm4NOyZx/RKtwBj8UfF/sJ
	MUu4eW6dgcL6XjCStZm9t3ck+hV5PAWDCsn7CogjlkRRfWzdtU0p7c4ble3BBZQ68IO3Vk8AnJe
	RmL0w1O7FECukfIIdgP25f5vXI8TmiLHhH0nRSBoQPWlHRvQkvzFl6ilUZwmSpnYEXdDnE6oYmO
	LI94CA+xI6maAxpGIhs/tS9MpoNAwibpDh/0dWpILTsCg6WHYg3YyvuRRSi7W2Bd/lQ/7I+qOnr
	Y6ANuSrtXph3F108dmjfUG0BonAbASE74X73PDO5EfsbfnxGQvawUEFCCtgSlesIc7b25NMdCGA
	O0i5MtZjwBqudWmiX90hedEcOuVqgrA8ud5asZcZ+JsE7LKnvNtktgzbJOvIsDdQYTIBxq3XkYS
	dl4bMcQmwiCe6aDllUNN+ZvTTG5laqdHC1TQgOzA==
X-Received: by 2002:a05:693c:2c86:b0:2de:cc07:e99 with SMTP id 5a478bee46e88-304fa49ce00mr7059212eec.7.1780367417739;
        Mon, 01 Jun 2026 19:30:17 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ee0dd8e1sm14418669eec.21.2026.06.01.19.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 19:30:16 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 26deb9f9c427c0382f855546d23dba76c49e680c
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 02 Jun 2026 02:30:16 -0000
Message-ID: <178036741652.9044.17141171124278402719@330cfa3079ca>
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
	TAGGED_FROM(0.00)[bounces-259691-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernelci.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev]
X-Rspamd-Queue-Id: A5F776273C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/26deb9f9c427c0382f855546d23dba76c49e680c/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 26deb9f9c427c0382f855546d23dba76c49e680c
origin: maestro
test start time: 2026-06-01 16:34:33.643000+00:00

Builds:	   44 ✅    0 ❌    0 ⚠️
Boots: 	   71 ✅    0 ❌    6 ⚠️
Tests: 	 8008 ✅  258 ❌ 1775 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1dd4e42cc72b6e94ae5dd1
      history:  > ⚠️  > ✅  > ✅  
            
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1dc52b2cc72b6e94adb391
      history:  > ✅  > ⚠️  
            
Hardware: imx6dl-udoo
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1dc5312cc72b6e94adb3a7
      history:  > ⚠️  > ✅  
            
Hardware: qemu-x86_64
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a1df6a62cc72b6e94af519a
      history:  > ⚠️  > ✅  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

