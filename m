Return-Path: <stable+bounces-217527-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDh/MTjHl2ma8QIAu9opvQ
	(envelope-from <stable+bounces-217527-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 03:30:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D7116443B
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 03:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D5173014437
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 02:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5BE427E1C5;
	Fri, 20 Feb 2026 02:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="oqzqecZi"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8622BE033
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771554612; cv=none; b=qmfhFm7/hBIQYDHPNNlvQjWBf3EdK2fO34mmx3Hqi2nESQLH25jpoDfW4+A3ENDPWNvlzeB1t2pMQKVEv9qr85oH/EqlO4bYhhUWcYrbo+3/EUVqKLWj1/SXfXARlbOTrylQJPF3tPXf3QzSVHCxO/jujT8VMwbKnEMNxrS+aOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771554612; c=relaxed/simple;
	bh=0ucVc449LZJSow5SrJr/ZYjYyanHcO8JkOb/ytogvgY=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=i3LnQdh6KI0S4t39W+sR83yLUojEhundJDzMzlH0X2DI99kxKcv4cBAEsjjanUXoNuaSF9kAaGzyNOTNwhwA0lboxt5HPMUS592kMStXxg8oubUd9ncaAC1q+ECW6VZTGHLNNvjIF/6ezmd9Pjd+M2k9BsGlN28Ps4w/rjHqTro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=oqzqecZi; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-126ea4b77adso2086675c88.1
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 18:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1771554610; x=1772159410; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09zGI27jvz0mP5k5CE7n3fPf3I1giaidh1eTQLIOL1E=;
        b=oqzqecZivSsA03DL/cD8Ml3v3wIuE9KKnwrCiuiT9Tb29YbEXXMw/yUVij0kVvWOl2
         VI6nVlg0f834Km7TI7GQrwSSp5Ppg7zW2OE40egzbmJ2yUniazreYAOP0tP7SbyWeSDH
         02tjD5BwfObcafd2np+/vdTl/KNOcsAL0FwZkGjqPKlNypGBJ5wPp4Sp5NPcMVgeqpU3
         FDLqRkGy3wnEamOQ01m4l7fw10uiXLUnXaUmtaO6WG2wAY/0xBnjTAmy/mHTAbR77lAu
         +DwRbJCUFzqluhoNZHsPdzYLouLOl9pWLRrV7ynzxaApoaUXj+ogbhWhHFiDLOrY9VLj
         63pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771554610; x=1772159410;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=09zGI27jvz0mP5k5CE7n3fPf3I1giaidh1eTQLIOL1E=;
        b=d4Ks8GpyoguIpW/nUYu9wdWPpFZG4j52qRRG06jdpw2l/vl7Hb2tmrzKXyWpzYSyJ6
         XSIoIspo9nozoO60Mq13wT63y8b26D88RvDhe78wk2nZ0PmJY5LYyFGcTnqrcenbalcl
         RN381KonGjiMnF6nSINPSzU1IlhYKyy/2rxWuQIoS9B+L/4q/keuThy9pOybdgvnOdFy
         EE1I4Cw6FnQLSE/tEnpXaK3cKoTBpMiREl1qk6ykWzuqD4eLQN7vdlSoP5JDvlUEksnW
         /c3nEp8kY2xf/WyozQjHn5ApYeKsfrLr6ee3zzB40Wf5P5zgBJrNXTZVrUbazDUpgPKP
         G+TA==
X-Gm-Message-State: AOJu0YzgZKYljKeMqF5uoJzti29yzB7iVf1AS46mVhYTbt/MOOHz64Jm
	JBBgBIHP/3SfpkljkZcc9cnEk5LhJcEesaMplHJfQlnaX7AS4TsTjN4JaC7/3QutGlo9QtGNmM8
	wQ2XWq0U=
X-Gm-Gg: AZuq6aLpqrzrT0A/QFwWJ30Z6TtsrLzuveMqNrZAVQ5Qdu3UAcIkMGEBEh2IgkVOXJQ
	D726RTOZsIW0vIhD0FTe+c6sPEbX2Bep4RWnHJw6Kaa4MMsOvFpQy95pG3M6aozcJDTvSgcfRIf
	iuliyuXYf4738Fcc6M/iBjLVyF3DtiWsbHUzl9yCjr9EUF/cqJ/c7AZJdQiaHEqBR0uT4fbKh+i
	JnSRRy4pjH2VyBTgmFzillyIw1jmOPDK2Vz+XenY8+yOa0Zc3oVXKXsMgOsIaZYUJvO2tE1SMTq
	EuXY9JVT6DsjGK0dF6U3EbAL4Paj7T+iS4b/4ziM22MU93aZz2xsheg+VJ0D4zEv9gpYzEG6p11
	pcM0qMf67G0RHMjMigSbUm8slAQKeHQFkHSOlOCyPMkEJB/l3p/JuXLNs9zrZOSp1pWmhFow89+
	vcI2rbe8UAGyT4U2Ea
X-Received: by 2002:a05:7022:2509:b0:124:9acd:3bd0 with SMTP id a92af1059eb24-12766026a49mr66248c88.5.1771554610304;
        Thu, 19 Feb 2026 18:30:10 -0800 (PST)
Received: from d14e337afe00 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cada1csm22434267c88.9.2026.02.19.18.30.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 18:30:09 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.10.y -
 3e2558088a1a3dc941eec8edafd002758ae97d77
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 20 Feb 2026 02:30:09 -0000
Message-ID: <177155460925.304.9760428761200974217@d14e337afe00>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-217527-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kernelci-org.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernelci.org:url,linux.dev:email]
X-Rspamd-Queue-Id: 30D7116443B
X-Rspamd-Action: no action





Hello,

Status summary for stable/linux-5.10.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.10.y/3e2558088a1a3dc941eec8edafd002758ae97d77/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.10.y
commit hash: 3e2558088a1a3dc941eec8edafd002758ae97d77
origin: maestro
test start time: 2026-02-19 15:26:20.928000+00:00

Builds:	   45 ✅    0 ❌    0 ⚠️
Boots: 	   55 ✅    0 ❌    0 ⚠️
Tests: 	  870 ✅  300 ❌  435 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:69974ed47b34c3305539d46f
      history:  > ❌  > ✅  > ✅  > ❌  > ✅  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

