Return-Path: <stable+bounces-253984-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNaFN7hiEmpIywYAu9opvQ
	(envelope-from <stable+bounces-253984-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 04:30:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7826A5C120A
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 04:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3225D300EF67
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 02:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8808625C80E;
	Sun, 24 May 2026 02:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="NxP60sjv"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB62E25C804
	for <stable@vger.kernel.org>; Sun, 24 May 2026 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779589812; cv=none; b=jw18iF/3lOtOBefEB1F5UNA9ePwz2ZF5ks55Dh3QYkEVnnvo1Nc/e5RQs5oprVBdFcVou7aInUCeSTuuOKuelw7GXumjUfM7i3UsYMH7dFSmEMAy7HrODMVx16uUf7bmA/3bZ7M4qtBelrgZIGvMmGEwOT/bjyUGuO1nA7dj2j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779589812; c=relaxed/simple;
	bh=yychFBmMT/hIci8DGBt0rg7Y9eXKiIni8GGeuiOGTpk=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=qSGOAtd38xGhLmNyNtwA4OmP0FxPOo+sHHuf58HH2SDWDYNtcVRk0n+YDZ/98TBr15VfeLH3cCzyYrPgHumD2tULVJNtb4NF/ZMUFmN51S9ie8bNduFUiXe3KEtqvoBffo0AX3uvXhfBSI6Bc/E5HOCPWyLZKAUqmwgmpHyaw+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=NxP60sjv; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso14514940eec.0
        for <stable@vger.kernel.org>; Sat, 23 May 2026 19:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1779589810; x=1780194610; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UZHgQQkW2bvY8/dZI+UQZWiYlic7zwlpp4jCwDVFdK0=;
        b=NxP60sjvOLCV0lVdIyhOp1SyM9iKdW9wO9sDmI31RExWiOy9AFfK/TVTM9OVQxc3A1
         MsJvxYsPuLftFAM7RbhDuMwxdFCtIcKtT1EM9uPO9Fy1c3L2FvoHcrwnw0OIVbE9A89e
         Urv/dTJ82uAXPzkwAnGps/W+9n74kiK/S2hgHKieu6IcrTCrq7EoCA2oT6JZ7rIk58C5
         QBLGpP8yT5YRL3ZwdFi0rpEo8IsBaL927W7NUsa+Z4VITJAZN4Qr4tQoIIv1IS8G7E9r
         uothsEuai/vXIkawZZB0krCvQmR90WGCnbjJ6Zao4iaJfw89Oya3HlWQIuXcRuECXw9k
         AxVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779589810; x=1780194610;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZHgQQkW2bvY8/dZI+UQZWiYlic7zwlpp4jCwDVFdK0=;
        b=GAZoxf78KbzEKF7eNDio+mAw/UAWBfkDKKjv9EFJDRILqrPGbuWGf34BkUEO9IxQCL
         nRBdGnyousCAlGYkzxyhnlVI/Wgm45Gqmiby8L4lOfIu8Q4LxLbwFdQe5ssDOpLHpo7J
         X5QUDeSPQEaH52VqaU6fXXOnIsKAxcVvSmfM0X1+ME9Zd92YlW3vd+IzH3EmwKPYe0bP
         GCDWaSt+YcaTGtGGn4am8bLArW/vDte7E9bVmjWNLE1X6FGUiPpMjmREZ8nt7N4xADEv
         fkfZX0GtUr1InB/lX0uxg87Ta0Pin+PeYRlgL0eFae0uNe71I4ZJf9939fp/Z4VBO9uO
         NdRw==
X-Gm-Message-State: AOJu0Yx5wS7/aYRM2a3Py4SWFC1qr41a4Putkw21Oma7k1U4sJaXfvJX
	f9MDOx/6SEmCxl2Z/NoAPM7JZdrEP1TQCDNWeAIRzxUwmCrUovgRhedtCTYsBwWlkYbiiTZFstM
	oJAIT
X-Gm-Gg: Acq92OHJaSHYWUatW28I7KjvqnkHkrgLkwT+pV96r4MIc3uPlhaKt8TjKQYBlzm92mE
	TiPhY8SLNzDHzPEXRtizGOHV8PxIqiyUQBoqnrE7K7XDvwzdt4slwipBaYolQJ7lyXFOsHURO+p
	wduj8/9FaEx+JJN/kqZgp0vd8ZshDjuOaW8Fm4Zuh+WmKQFOmFuQG7ia4yLSdyAT6uZBQJ/Fepe
	/bQwozDdiUVrt4XJdYzDEekx1tLwR4Es4pn/y3A2xZGStaaImyPv/yy82OoplPmmBgii3kVbE/+
	W8L3Bac7qYGBMYIxCxM90NC/JRmTsRsu29OoAmUpk9cbPIU1J40gO3+oD7RBh7Y1WVam51qtkf+
	YeI1oxi8MxpSQ/x05wyWyiKTzqi0VhtnBmylVfWaOJawUQWQItwzZmQZyjFjeilLN2hzZf4uPPt
	/P5Rn12XNcenOCzVeo
X-Received: by 2002:a05:7301:578a:b0:2d8:97d6:6abc with SMTP id 5a478bee46e88-3044915ff8fmr4466702eec.22.1779589809797;
        Sat, 23 May 2026 19:30:09 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3045245fbeesm4709239eec.30.2026.05.23.19.30.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 19:30:06 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.15.y -
 241d66fa280c91b65942d641e92d06c9ae6a0b95
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sun, 24 May 2026 02:30:06 -0000
Message-ID: <177958980570.4906.2284580874835084575@330cfa3079ca>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-253984-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Queue-Id: 7826A5C120A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

Status summary for stable/linux-5.15.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.15.y/241d66fa280c91b65942d641e92d06c9ae6a0b95/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.15.y
commit hash: 241d66fa280c91b65942d641e92d06c9ae6a0b95
origin: maestro
test start time: 2026-05-23 12:15:07.678000+00:00

Builds:	   38 ✅    4 ❌    0 ⚠️
Boots: 	   36 ✅    0 ❌    5 ⚠️
Tests: 	  483 ✅  170 ❌  340 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a11af0b5bf5d05c9744fc4e
      history:  > ⚠️  > ✅  > ✅  
            
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a11a6715bf5d05c9744f2ff
      history:  > ✅  > ⚠️  > ✅  
            
Hardware: qemu-x86_64
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a11a0065bf5d05c9744e276
      history:  > ✅  > ⚠️  > ✅  
            



This branch has 4 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

