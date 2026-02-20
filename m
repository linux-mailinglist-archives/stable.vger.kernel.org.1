Return-Path: <stable+bounces-217526-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJ4UJTbHl2ma8QIAu9opvQ
	(envelope-from <stable+bounces-217526-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 03:30:14 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0DC164434
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 03:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3C159301469D
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 02:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403BD274B23;
	Fri, 20 Feb 2026 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="puXfOJBq"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f193.google.com (mail-dy1-f193.google.com [74.125.82.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02327145A1F
	for <stable@vger.kernel.org>; Fri, 20 Feb 2026 02:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771554611; cv=none; b=BoGGnZSjqq59nBMDaqj0dUCYwlL0y4NaaSS/Jr34UFEm3ePxZnWPe3BgGzW43pl/muC8YOLODlM2OurEOUEmZvppQX7yjR72u7CX4AG4TDCD5xzKfCbgDOkC1UwQdoN6wkp2E3ixpDIfLpbdVb6gbyVEMjUMgCjZJQQlukYuc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771554611; c=relaxed/simple;
	bh=AoGd6hLjtiR1bjYTEZQ7rhD7CNVcYTf5vtafOJB2jW8=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=FAbEBXOGr7thkZaKhLWg7AuzhOZFndTWPFslfXhwTfkAhC1wF8gLGmb46Qxm1fTPGXz/3QnNMPLWwnSQCq3FEtL8HTuZQqy050ymk1BdP8BOqkUYlQA9bh3UX1GSOc1cArNqTVogTUMVAkSRChTWkiq/RCyA98THrc6/XodzmrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=puXfOJBq; arc=none smtp.client-ip=74.125.82.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Received: by mail-dy1-f193.google.com with SMTP id 5a478bee46e88-2b82c605dbdso1911961eec.0
        for <stable@vger.kernel.org>; Thu, 19 Feb 2026 18:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1771554609; x=1772159409; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDDZSDRi1g/Fqyl1/k1ntVmjhR9gsDK1V7NwoGkT1gg=;
        b=puXfOJBqhoDMar2r5ff7+k4H+WaLK2UYBEcHjJW7yOclF2qbh7N2PrqWXtTXN4hlaw
         zCaXgAkxNjPg5/QwHNGOzjOOBvFyebqMUKgZdO+hTOQxCBcTiMc5AZVq5EvcOCv+HPsp
         hB4d423wQTLjUGVKR+wuLJurIwfJXyW9GhsAgVKiw3416cZzc2HZHXllPoNc0EaEBbgu
         kVDcgrAF/QZ3vm4mlOU1T4mSPK+PRe3qNHYmiZCYdDctUlUAUaneDJYCYvhSELIm33NF
         OXyLqB2bw59lwXCX58ROZ+J/TwUghkHh05g/G7cXwZDyZfrXbmcRE7SI/rxf4DxxDDs8
         e0kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771554609; x=1772159409;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VDDZSDRi1g/Fqyl1/k1ntVmjhR9gsDK1V7NwoGkT1gg=;
        b=I45KB5y2b82XlCCm6XrgJ+kwyiozbDU01v16FKfiq0wHF3/OJUr8J28fxXpPehQOv2
         tqWhk9rCHwBPAOzeyymPmXOvPNHptN8o5pwX7dcr1YT/Q1lRjB3WKO0ApsXU5Zs59DNG
         QQXKk1em/Kwr/v3l0av+Gbc9LqEmOEW/5NKiEZBJHCIMcfIX/emjfXRVoGqNslKoWMkO
         8rV0l3/9xeNb1KyLu5pksFPM3K2q+wGUczelGWAcPE/glB62dFKjzlAepf/08e+RLoF/
         3Uly6in5+qaTMA2r12LNB2W39XkIOyIClXgFAS3T+l9XiODIk8+Dc6cxWLGIYR3zq9mP
         ZzlA==
X-Gm-Message-State: AOJu0YziJPS4zG2o07lB4hJ7KpIu063Sldhg+BfQ1A6Esx9H4Zp5kV3z
	cGEQxA0TlJXBAhSt4VXsujippF4xr7iuT0RZt2fwrlwpM04l0v0ej7243s6oDD8Q9M4=
X-Gm-Gg: AZuq6aLa5BzAk202I8vVnClkY7THUEp8DHtDvPAm0W8pi8L0SQ//Rwa7Sfu43a3tnf9
	s/1GtDmf3R5rjpOAsruuw7aqG0+a9amcMzqQEIx4w8f4L21E7o+fAtJt9CiOX6VVu6zP/p57DtG
	FEUT9A7rFzj4GB7+qAI+ldb2/gGNVIrTHUA05Hcp8Eg2rNW42MvBEmSSPG9BXoglTIvWbLl9Npn
	0fO3GbNtWDWA7yeMl7K85akYzhVTws7OlVUgIjx1C5hf53DMPl25wn+9Y1zpq4WbDuAxB3ZD5AC
	OtteZUujzbYqk7eq7FNCJC9orqOskyNM2/YciEAapeMdQ2KLsuoTQrtVXOcI/UiOpONJd6Ffe7G
	eUTr0Hx1zqEaHaltNZbyDcjLuYt+DSlcFjsqMVbyiZo8LQ7qFo/kA17HdHsQbe1OtckI+pnMv/d
	gw0I3saoNtXb09HUU4
X-Received: by 2002:a05:7301:6507:b0:2ba:7b71:4f4 with SMTP id 5a478bee46e88-2bd5018abd3mr3786792eec.32.1771554609019;
        Thu, 19 Feb 2026 18:30:09 -0800 (PST)
Received: from d14e337afe00 ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb669f7dsm21686453eec.23.2026.02.19.18.30.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 18:30:07 -0800 (PST)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.15.y -
 3330a8d33e086f76608bb4e80a3dc569d04a8814
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Fri, 20 Feb 2026 02:30:07 -0000
Message-ID: <177155460744.304.12732429259651401108@d14e337afe00>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernelci-org.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-217526-lists,stable=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,kernelci.org:url,kernelci-org.20230601.gappssmtp.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE0DC164434
X-Rspamd-Action: no action





Hello,

Status summary for stable/linux-5.15.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.15.y/3330a8d33e086f76608bb4e80a3dc569d04a8814/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.15.y
commit hash: 3330a8d33e086f76608bb4e80a3dc569d04a8814
origin: maestro
test start time: 2026-02-19 15:26:21.450000+00:00

Builds:	   44 ✅    1 ❌    0 ⚠️
Boots: 	   51 ✅    0 ❌    0 ⚠️
Tests: 	 1025 ✅  383 ❌  903 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - ltp
      last run: https://d.kernelci.org/test/maestro:699746807b34c3305539bcdf
      history:  > ❌  > ✅  > ✅  > ⚠️  > ❌  
            



This branch has 1 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

