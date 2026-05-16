Return-Path: <stable+bounces-248967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hYbTF7TWB2qILAMAu9opvQ
	(envelope-from <stable+bounces-248967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 04:30:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBC4559E56
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 04:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 64E923017519
	for <lists+stable@lfdr.de>; Sat, 16 May 2026 02:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A625F1CAA78;
	Sat, 16 May 2026 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="KWYAwmyd"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030329898B
	for <stable@vger.kernel.org>; Sat, 16 May 2026 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778898608; cv=none; b=DV/F6KBW+RpDG7DVhrn9+PKET6BQahmB30dLoHe/0eY3ur0PvhVCG5JjPibWyQJc5LApyFtALDCJdg4nNAPgWfp44SHqgp1U9fpFAlyKqUoE4IbeOdvUExH5RQUBSMj7IdR844GKLcuSNgTdjkra9UNCiQhUsxbB34IQ359+6oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778898608; c=relaxed/simple;
	bh=KkMED/vPamcvcF2WiDDndFFZ6We0lUZKQLsgu7Gu4FQ=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=UOXR5a9Dyf7zJ5jJ8lKDHIdUIg+f6P+pLz/PZ9EXmK7MpMoFlqgIhCKB9p1wRccTz9xpgqQRLmnWjgUAj6kS+xupxU1Ytjfd0SfD6XVZ2z313ZBdhfKQlwR7tt/ZlxkpmeFfxi/SjC9LJtXsBzfax219cNpeFXj/5pDUwFZjB54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=KWYAwmyd; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2ef2a1cc06dso2411142eec.0
        for <stable@vger.kernel.org>; Fri, 15 May 2026 19:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1778898606; x=1779503406; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBtxOB3M88ogPJdMABfrqorLJwxbF97SLV7dE1gcYpU=;
        b=KWYAwmydUgYKg6UbTA1kRnE4jFIzA45GtFboF9wyzYm9mVOsJh5yUB8tgACAg9wmms
         RTaiEJkoMjyzyL0yqT3F4I29FYREg4+Oce9EksU8jzhrpxhy8svrvBNfNqtZYLqaEMF9
         GjtxAznZJdNLLtSQFgGc9XmFO3uw5IBcA0EW9+w/tdbLQ7QhotSWLApYeJKrmML7VwvQ
         Q0c6LWXpcVkXA+TGqJc6vEUA1PbXBgZehPrARa47XGsfH2jUY3PESxfmRR8Tz5NVwBLl
         Ey58yNfmug7exkIXRVzGyOH7lNwyZCYCHQTNmL6GX8fVuz0V8HNpkJdjcMxj75AAhDwI
         IQTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778898606; x=1779503406;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EBtxOB3M88ogPJdMABfrqorLJwxbF97SLV7dE1gcYpU=;
        b=eTKK27vH4DFdfOTmpGzNuvn9Ir1oKbe2qw3B+Cuu6Pcb0o1hgxZCzIhw4AFlzjM5Jm
         19Ew2AVpKp/O2ETrSyz5eQ8eHl9dMnLUPY+ooxFq5sAzFc19KJMyE3o7FgWo86rgqOmH
         5obA9MchJrwwVc+ewbxn6pok/9vAVJy6rxso9siyNe5NKgKU+217t46oCp/ijQoIUTeJ
         Lb9TBhHkUJ8eP+41oI8WPVOTo0IB2J2X0XQMuzVVfvo3clEtfCJ1sCIMUI5cSXqNHSjS
         G0ZhdWoaXYMuWjH79IT2MdIWfkIheTYXKm4/nRwU+W+xo/0m3kHvAIKSyRHHl856N3C3
         eUgw==
X-Gm-Message-State: AOJu0Yx6zBOs2hodrzg0IZ8pdpq6iznVhvYTQKPycLPBnoibZDjIX6a9
	PdXtfbr2dEn4xLzKz2tkd/cneO2zJtClfm3+9GEsRJMWBu4wYYguP0yxqBxZW7/LH4HIGV9IFuZ
	bBLmM
X-Gm-Gg: Acq92OG97egmC26em+KRVPtW9WJxgjKAQ9uvKgaVDfYcQaCyXWMybJkBJD0dhm/oxWK
	9KPKc5vHj8xdEg7L1oQ5P4hynGry94uolJ9PhbbySnzJ5FMwCHO4eYyp0UCej+uo7kP8gBD1yTd
	8GHuraWhCYe1dhJVjFr2gGd/n+ANfDMV/jEOnlD4qQxI2Oov9gVz64WJZxjFOuumcKVhkV4rJtN
	JdgG5Bv4KV6nK7idwDTI/YaJguA1OH8vByiYJvON8U9ALdVcV0tq80ucFEPF73BX6Bl4xHnM3U6
	Gu+CWIaG4JZOf3pSqxRavA93W9+b1ID94rJL25MeLBWMqGee7cX40UTr/usQOw//Z+6Cx7p1x3Q
	tJ92iOCbqdAXkRreTooas4aovI8FO/XKoS8VJhbgccE4D4pNeybLGiyKVNDLQ4a1o198WA3IaiI
	esYI62b/Taf88bypdJ
X-Received: by 2002:a05:693c:2c81:b0:2ed:e17:d510 with SMTP id 5a478bee46e88-303986a682bmr3294753eec.35.1778898605854;
        Fri, 15 May 2026 19:30:05 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-302977a9474sm8706356eec.25.2026.05.15.19.30.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 19:30:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-6.12.y -
 51eba7e6c91ada319dc9ebee3f88e4472b5efbc4
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sat, 16 May 2026 02:30:05 -0000
Message-ID: <177889860480.1228.16529486492012685201@330cfa3079ca>
X-Rspamd-Queue-Id: ACBC4559E56
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-248967-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernelci.org:+];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[kernelci@lists.linux.dev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bot@kernelci.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kernelci.org:url,kernelci.org:dkim]
X-Rspamd-Action: no action





Hello,

Status summary for stable/linux-6.12.y

Dashboard:
https://d.kernelci.org/c/stable/linux-6.12.y/51eba7e6c91ada319dc9ebee3f88e4472b5efbc4/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-6.12.y
commit hash: 51eba7e6c91ada319dc9ebee3f88e4472b5efbc4
origin: maestro
test start time: 2026-05-15 13:27:59.770000+00:00

Builds:	   44 ✅    0 ❌    0 ⚠️
Boots: 	   74 ✅    0 ❌    0 ⚠️
Tests: 	 7785 ✅  498 ❌ 1708 ⚠️

### POSSIBLE REGRESSIONS
    
Hardware: k3-am625-verdin-wifi-mallow
  > Config: defconfig+arm64-chromebook+kselftest
    - Architecture/compiler: arm64/gcc-14
      - kselftest.kvm.kvm_arch_timer_edge_cases
      last run: https://d.kernelci.org/test/maestro:6a07405d0ed99f002e8f0733
      history:  > ✅  > ❌  
            
      - kselftest.kvm.kvm_memslot_perf_test
      last run: https://d.kernelci.org/test/maestro:6a07405c0ed99f002e8f068f
      history:  > ✅  > ❌  
            


### FIXED REGRESSIONS
    
Hardware: mt8195-cherry-tomato-r2
  > Config: defconfig+lab-setup+arm64-chromebook+CONFIG_MODULE_COMPRESS=n+CONFIG_MODULE_COMPRESS_NONE=y
    - Architecture/compiler: arm64/gcc-14
      - kernelci_watchdog_reset.wdt-reset.wdt-get-timeout
      last run: https://d.kernelci.org/test/maestro:6a074a290ed99f002e8f3e19
      history:  > ❌  > ✅  
            


### UNSTABLE TESTS

  No unstable tests observed.


Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

