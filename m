Return-Path: <stable+bounces-216767-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YE/fL8rSk2nb8wEAu9opvQ
	(envelope-from <stable+bounces-216767-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 03:30:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7341487C6
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 03:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFD483002D02
	for <lists+stable@lfdr.de>; Tue, 17 Feb 2026 02:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52D8F199FB0;
	Tue, 17 Feb 2026 02:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="YvpJJ0bE"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f66.google.com (mail-dl1-f66.google.com [74.125.82.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CB13EBF02
	for <stable@vger.kernel.org>; Tue, 17 Feb 2026 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771295429; cv=none; b=O/dM/qG/tWP8Oe90QqMAGL/A2a+N6RrcNQJEL00xlI/ij/dN2ZZhIkxY2xZGnwc0/U46RoyXKconzv8YyZlmC+dQudBBDHoPG2fp4ZDqG6tja0pnnlfQJXyAeZMIX0Et8AvL0EjCG1ANXH9sB8s3F8UefzwAK36AB6dgufi4q08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771295429; c=relaxed/simple;
	bh=LfT1qw3Q77fW0eUP/mkuGu4lPv6gDEQu5DqBGOI3iNk=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=AvQCYxYX4Z2O1QhVbne0hKeDUZkhTMuTDy5VVSmluykliVBg4fTxTVp9tj6fQcztgfL/uRQaDjVRziEjEkRPtq0OCOGWMfBHkvZEzJ/+u0adRTQtR0WoVxKAb8wbug3BUUChpUHInJmY92fu4sH4mTxSqObrXioR0a+or4Hmtso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=YvpJJ0bE; arc=none smtp.client-ip=74.125.82.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dl1-f66.google.com with SMTP id a92af1059eb24-1273349c56bso4753475c88.0
        for <stable@vger.kernel.org>; Mon, 16 Feb 2026 18:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1771295427; x=1771900227; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2m+O4zJkQnpiAAqcPOdVhFvkegNVzH3yv7asbzL1XeM=;
        b=YvpJJ0bEx+8jbaby/O8L3TFt0x1Wz67hllpyBmpz4Jzy4kU/OB7WNS4UvDxsWn4iVM
         wY1KVTUqltJcoQ2ghefmAmBBvNGVM5hcth+r7Y8VnlMvFChqDhjhKI5Mzbdl/sdI9Fy3
         LyXRowfWp7bTtjsjqlnNU1KIMNAMr5u9fta8Flb6RFNdaJxBZ3odgKMFgSfA2RFoaPVH
         p4m4OQCO23IoyIG0J+r68HbpteozsjJofW5GZI6wHj8t67qpJLmQakq330lu64VD1LKn
         K00JUsIwDBnyeGTZGjupVLkforIiKjs3eJApw7/MEZL/9K+hIqvCSk0AhrQp07LmcFcq
         QSyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771295427; x=1771900227;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2m+O4zJkQnpiAAqcPOdVhFvkegNVzH3yv7asbzL1XeM=;
        b=tgLBw2JrDe7IOI1Zdrv30xBEl0SxNS13xG3szj671UiumdZRe8xaCdpqsYgsJRMZDR
         eXlm2PM1p5zOABY6+ahPJUEHSFtbGhd8hHhmQCjLUJs2i+WPL1QHn8p8VcpbUGPtBH+5
         GhuhWgSJa2tOo1LO2A7ulQFX8Rgp2BgTAGOP9n/mr+Fuz8U0091G3jzACP1vA/ff5I7Z
         xGg0dme5aSslF3l3HUemqTs3C48PJxJLtJkNffHUjxqrvschpH4bEIWA05V4hW0jTAoQ
         HU3GGIF7fib5TKCTMc/wWWAY9l+HGzdnF05M0zERh5OBDuPRvrBVE1/sBpAewfMBwjZt
         Wxrg==
X-Gm-Message-State: AOJu0YxVXPDezIV2flqAks3JWqGxAMjbZB2N1tQOk159PRy6WRpusNgo
	1tSunLqk+X7gyLw3HwaCRoah8Trk7UCcVHDC9pdsr+QNJ5WYipoYI6FR2vlmr5V47qt+/kDCFsr
	HEKK+sB4=
X-Gm-Gg: AZuq6aK956iper7gped3IQAXlYeY0sDox/8xoA9hfEslo1BcOstl2BZQXTN+sGD5RQa
	XHKoWJhCEqzFo8C3+OCzrgmf5Ta/YY37OAXoZghqmbWRO3ahyZbNbp/jvS/HDB7/C5qcGDJW03l
	wa9EbsPK4IGUO9bwZ1YfNrSVU1PtmC/G6w2jVnX5fA9jNPBcRcruOw8thihdtREGHAr89SLXTl5
	Y+kBO943IKYboL8pa6jXHrP3xupxVZwy6lIZ2HoaZ7z1s2FCzmzetzzlgOmgA7WIujj5E/gvHEQ
	QCH0+QfjYrCi8h73Uvhj3xogMCZuZBWX3fHgQsZQdXcIVWIeiGy4dHJoSax/1sS5Zkp3aTksulx
	eWJ+uWZRaKS0tu9k2IAKoO9KWbpLbpDtDUvwVjfMDq9NmYM0lsUNPQFqVwgNtnJvr8CPbfay0ec
	6orNROsiOcmdNNucGB
X-Received: by 2002:a05:7022:662c:b0:122:415:25ed with SMTP id a92af1059eb24-12741c04457mr4620999c88.49.1771295427075;
        Mon, 16 Feb 2026 18:30:27 -0800 (PST)
Received: from f55b40a4666e ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742aff32asm14128501c88.0.2026.02.16.18.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 18:30:26 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 5fb0303f6cb6a89bcfb19bd7a68cb793c86e78b2
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Tue, 17 Feb 2026 02:30:26 -0000
Message-ID: <177129542607.2933.6182068394303328725@f55b40a4666e>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216767-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[kernelci.org];
	DKIM_TRACE(0.00)[kernelci-org.20230601.gappssmtp.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lists.linux.dev:replyto,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kernelci.org:url]
X-Rspamd-Queue-Id: DF7341487C6
X-Rspamd-Action: no action





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/5fb0303f6cb6a89bcfb19bd7a68cb793c86e78b2/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 5fb0303f6cb6a89bcfb19bd7a68cb793c86e78b2
origin: maestro
test start time: 2026-02-16 17:09:18.707000+00:00

Builds:	   40 ✅    0 ❌    0 ⚠️
Boots: 	  197 ✅    0 ❌    0 ⚠️
Tests: 	 9121 ✅  474 ❌ 1524 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: acer-chromebox-cxi4-puff
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kernelci_sleep
      last run: https://d.kernelci.org/test/maestro:69937da9a1ae387ffbdd9570
      history:  > ✅  > ❌  
            
Hardware: dell-latitude-5400-4305U-sarien
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - kselftest.cpufreq.hibernate
      last run: https://d.kernelci.org/test/maestro:69937b7ca1ae387ffbdd82c5
      history:  > ✅  > ❌  
            
      - kselftest.cpufreq.hibernate.cpufreq_main_sh
      last run: https://d.kernelci.org/test/maestro:69937dbca1ae387ffbdd973b
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_wifi_basic
      last run: https://d.kernelci.org/test/maestro:6993807ba1ae387ffbdda318
      history:  > ❌  > ✅  > ✅  
            


### UNSTABLE TESTS
    
Hardware: mt8183-kukui-jacuzzi-juniper-sku16
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_wifi_basic
      last run: https://d.kernelci.org/test/maestro:69938077a1ae387ffbdda30f
      history:  > ✅  > ❌  > ✅  
            


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

