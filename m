Return-Path: <stable+bounces-212927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cA6xAjJpfWk4SAIAu9opvQ
	(envelope-from <stable+bounces-212927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 03:30:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8C0C04C0
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 03:30:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 607BE300382B
	for <lists+stable@lfdr.de>; Sat, 31 Jan 2026 02:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61968C1F;
	Sat, 31 Jan 2026 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="SWfpZEbt"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC31C30F808
	for <stable@vger.kernel.org>; Sat, 31 Jan 2026 02:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769826606; cv=none; b=nwIIhjr1plBeYJAYDIGzAA4K9uKMxzPT4cfwUh6BIdfkXDzwkLzyGBMHjolVZHqcGjGgRIa1uvJaKeIWUtso1RhE8nwdQsMw1/XphNzqX6tjY5k9pYCtMrV6tSr65SlPPwDxGulTWishaFtr28AXanBafCiHBkF4j0jIu7N1nTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769826606; c=relaxed/simple;
	bh=aawpH01g3NlljyX4vMWX6V5ZcLZAMf3+k7RK0tyEr1I=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=XLxihbhpd+U/8k6cxgQKdNtjJA2YGQ66Kh6Rbinf/vdAAZWIF2ydU0UfMoseeGF73QPE16AIohXRqnuxSOHEKRy6y5hY9pn82Ak2X/jgSTcij/1IpUZxDobAGYQ+NDouHCqPqVIL2dY+rsGHavN/hLkl2kXbaOmpSfzBllbvi9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=SWfpZEbt; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1248d27f2b9so3919110c88.0
        for <stable@vger.kernel.org>; Fri, 30 Jan 2026 18:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1769826604; x=1770431404; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=63ki0YpAxle07rAQjlDknWShS7mPY1SLG3TD9Ihu/4M=;
        b=SWfpZEbtnyLod1diEwqVeqnqY3pG3YdsqcLi/sGXTn4mtdotMqRsxyjxr8z5PpP/RM
         sflBefKSQ+BzO57jiFN3JdGHqJefhFRu2GuOw+ahe8uwI2QTLAIjxQvTMzKIgXuaCJx3
         awm5r47dR+hM2nrouWZOJ9gQfW3F81gHjfjXZm/wBn3HtVOYHHih9Hl+coEP8Syv4cmE
         Dp0K9FTwKAB2eB5qhe9s24UIAn5rh8Xek5MrYbFQgUs3dE1gSGgle+MpuYmQoBYCx0DZ
         skjH0azaC545umUX48Kqi2tYqo3BkeRbo+ajlsIbmBNaA3KSy5qZrDRtzCP2Ye39r9Xa
         FQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769826604; x=1770431404;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63ki0YpAxle07rAQjlDknWShS7mPY1SLG3TD9Ihu/4M=;
        b=gY9hF5Oc0ktjtT8/ozMvwFfW9eObH/gCTjvuCSG3DhwytDJSnKA/mUQExeekVOozON
         JGWsWwX+/kKjHKReP3dpbEDvnuvVrmausYusCk8NbYPKMd7JUIfAtFueB1BYd7QA2DZV
         3h98ujiBidJyT7CG3NFOmfmxsl+S18ez0otkUDz3B5NAw1UHMlQID4i/dklYedhmnlfy
         hdnnvlSpotblygIpMXYd5Sb3tNv/py/A5KT+1m7bAQfjkLmYQf7xIXvoFCGKMEO/KVJw
         iFoTLtaA56ZEsl8W1XxLF0VE2OpltrYlxnx6VlopLEFArkG7lyJOndULG3Yvzu7GYiZx
         d7yw==
X-Gm-Message-State: AOJu0YwX6JXew9C8lvQTRau4B3UO2RwtxIi2l8vV+l57XHQm/+UHmILB
	IrmsYAlfHnWuCJWXvZGoAaT25QWVQcKKWGG9S5EZq07Lvl0mnvY7uD/WIrSzZAyIz05fHQmsziv
	koGn983E=
X-Gm-Gg: AZuq6aKX1mZLkjNzARo/0guHw+Jq4Hu59ts4NK/lDfM7SBu5OrScaVjRitdfmZOwFhj
	vxGIVP7uGtr+FYnMMR1wvoj2UoQuFzS3eXpgyyQmvU6/D5tpxXkkHVvbNL4l15QGz2Ku4LpQVAs
	KDOKAQd39jgOcz92IFW+b+Soaacpki+w/rJWYollMtdQJoFwXtfLsoY15Fwzrts802LydDe5oR8
	6QPrmUab0L7mjeQA0Bl7Pfi3luSvIy9hD5cJp64kRsUQYJiPRLNVNhgYU8EzrF9KATGfxV/4DHl
	/Pocpgnf3BAEEY+1zRTlL7rNgV8XpD6hW4mYL+3CU2EDqZAixIZrM6cq7uPXJ7rfAGNEuKZvgDT
	Ewoe/paz7HI6maEx9QEmY9Ipw1kpswLY5z2Ox/8Z8aBADOGEox/qUXW/q14tAA/7Z8/WxHtNKXB
	nxmlNt
X-Received: by 2002:a05:7022:78a:b0:124:9acd:3bd0 with SMTP id a92af1059eb24-125c0f9a94bmr2636358c88.5.1769826603832;
        Fri, 30 Jan 2026 18:30:03 -0800 (PST)
Received: from 22d5995788c3 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-124a9efd3b8sm12242958c88.17.2026.01.30.18.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 18:30:03 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.6.y -
 2cf6f68313dcc3c404f49fdee41bbf3c694ad75d
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 31 Jan 2026 02:30:02 -0000
Message-ID: <176982660229.4838.1045825830629279728@22d5995788c3>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-212927-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.linux.dev:replyto]
X-Rspamd-Queue-Id: 8F8C0C04C0
X-Rspamd-Action: no action





Hello,

Status summary for stable/linux-6.6.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.6.y/2cf6f68313dcc3c404f49fdee41bbf3c694ad75d/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.6.y
commit hash: 2cf6f68313dcc3c404f49fdee41bbf3c694ad75d
origin: maestro
test start time: 2026-01-30 09:35:43.026000+00:00

Builds:	   40 ✅    0 ❌    0 ⚠️
Boots: 	   48 ✅    0 ❌    0 ⚠️
Tests: 	 1481 ✅  211 ❌  554 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:697c8256a1ae387ffbb6856e
      history:  > ❌  > ❌  > ❌  > ✅  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

