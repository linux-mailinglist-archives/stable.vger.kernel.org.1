Return-Path: <stable+bounces-253985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SMLWI75iEmpIywYAu9opvQ
	(envelope-from <stable+bounces-253985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 04:30:22 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 366945C1211
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 04:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 776CF300381F
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 02:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D09257827;
	Sun, 24 May 2026 02:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b="D6On7kmS"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C055E25B091
	for <stable@vger.kernel.org>; Sun, 24 May 2026 02:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779589818; cv=none; b=AISl+YsXacOFLHk+cuB54wJBwU17vzR+RRy5IMVp+t8F5vIV61kkO18UFVNrDvfcGwjmHRXOyc8vxqifvXKEIFeMIguNT+aSLtiEBNpREp9r4HGvXq9fUfaFRmEAayal3brEns2IlmcutcbBtNPXVw0IChhgoc0rUGB4uclBPvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779589818; c=relaxed/simple;
	bh=uVV0dQAy8zXOQN2M5QxT+5MZoiBcJI5PPJ/XPR1EyaA=;
	h=Content-Type:MIME-Version:Subject:From:To:Cc:Date:Message-ID; b=V4Q/jQsEyYukF/ZamKtS9aIXI/B+Pt8nKoDJM/ce2k9G31SInn77LF3TMcgj4iqyXoBuNGpFBuBRCjhSN9pKB3qF8mvrNBfCKlLSbGoZyDXQ7OLj/3yKurP1eN+fGuhxlTV3ZcxjIQiNdqG8U/zrSFWt/N8Ivz1u2eXwr2m6iUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org; spf=pass smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci.org header.i=@kernelci.org header.b=D6On7kmS; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernelci.org
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-303dbfbec77so9852411eec.0
        for <stable@vger.kernel.org>; Sat, 23 May 2026 19:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci.org; s=google; t=1779589816; x=1780194616; darn=vger.kernel.org;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9AGoLT7j2Lr0czSvxM9VmbERpIttl75ce2XPWTQe9Lc=;
        b=D6On7kmSFXca7g1y6VKIaIcrGdR1pXLiXLkhcsu8c+uuJldG1uTltTaRgJY8+RlQ4I
         tAOGy8lWr/+Ju7JGpj2Kn28N+m1T5mzuBT4itCDU4Wi5d732pavUulvtgvELOjjS0SZz
         rpWLDhvlCpFyLaYIH8ENUAHAM2iwnIqib5WYcqCd68gr0XyiAqgOUqM7zVtKfon+aAvg
         N8pkqtCAB87pLTX+mVCZoTckhAPLP+cg+YKkBeoOFtz7Ej5+8a9p4ojzfcl8tM+OHYDX
         jrFPnO/05D6bZ5QqWcGygyorYJOORwMB3oi+3xOirtalkOWpgK7YLqfOR5VD5+EQ8VSy
         QWnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779589816; x=1780194616;
        h=message-id:date:reply-to:cc:to:from:subject
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9AGoLT7j2Lr0czSvxM9VmbERpIttl75ce2XPWTQe9Lc=;
        b=fv/O64Dwj40LJ9QgcdWZglKlqkdoLrQz/EHtCPo82PMeZI3FhairQBmMU8snGJLbw/
         TF6/Eueg+Stw4wI5Mwxxt/SgXSzQM1C7Suoo7zAxpTD3GUHl4sHUtmTtFHbkT2ZNFKSI
         VU6k6OuUg0P9710XNn9ybjt+xpq3b0xKJxiTEF0sVoCm2qu0ZllVrMaMJULgAhIJ9A35
         3TJhjWJtixtGVVnH4AO/bGpmYgGY016N2BYUkOlFcH/xQbDrRFZaSCjpDjwRmxtj+Tia
         pNs/lqakIEFreyv4dbk1Vm/I3j7Jq5nQLQfrsZs7c74Q2i4/7GTfjT0BY4iPAqKH/QZ/
         hATA==
X-Gm-Message-State: AOJu0Yw1azZRdJNc/jYzyWwyJkmXU/bScbmRg4VnVnZACYl02Eu/YWDK
	ENQrvsRmbSSZVIsllI0X7gIJATfILmxL+Vqtbhk31Z5YWD3tufdWeUWyDq4+BW0jx2x39MDbll9
	YFtOx
X-Gm-Gg: Acq92OGuFDLoj7MMiBGNkl91QRHFozglLoQ1PtcVt92QhMx5Ba2RROrlAFw9XpH0YTJ
	RaAEr63wCVvf/Ap6pQ7h8NHFiXQS3V6/SBVeqd396Gnk49uEcsE/Ef7394YQl2Ez47ExlXTVvFQ
	fkXPBAs8nY8Q81ew9TWXZC+YgTMKpg+UdkfTWrFYjDDmlaPkxDcC7hl7p2DqW2ETcueKGkkjyU0
	ifZ9h/Tu4SPiafutO1ajYqt7u0V68QAp6NyEC8B6xgiyJbDFA60FmMl5IGEQB+hVa+05KEnr+gr
	1TW0SRWsoqxY8vOzKgjTxSeOtpwkh+sv7kDRP6kUquHp5T2j/RKLYmOPY9p3oANTNAIGhFTyb1y
	mtNfjatBKvhQn7fCJ6bwfyYeuVyIBnq6r4NcEiMmk9W+mwbJl2nc4Nj5X5adVBXLUu7c5qVnAK+
	HIKYlZqLIcH8yUwRYr
X-Received: by 2002:a05:7022:128a:b0:12d:de3f:f3e4 with SMTP id a92af1059eb24-1365fc6ddd9mr3364179c88.36.1779589815846;
        Sat, 23 May 2026 19:30:15 -0700 (PDT)
Received: from 330cfa3079ca ([20.38.40.137])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1366aba2b9asm4778263c88.15.2026.05.23.19.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 19:30:15 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [STATUS] stable/linux-5.10.y -
 7adbe121223f7e32ab7e2592a72093f80f4e11a8
From: KernelCI bot <bot@kernelci.org>
To: kernelci-results@groups.io
Cc: stable@vger.kernel.org
Reply-To: kernelci@lists.linux.dev
Date: Sun, 24 May 2026 02:30:15 -0000
Message-ID: <177958981471.4906.16600176582315815354@330cfa3079ca>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernelci.org,reject];
	R_DKIM_ALLOW(-0.20)[kernelci.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-253985-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lists.linux.dev:replyto,kernelci.org:url,kernelci.org:dkim]
X-Rspamd-Queue-Id: 366945C1211
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr





Hello,

Status summary for stable/linux-5.10.y

Dashboard:
https://d.kernelci.org/c/stable/linux-5.10.y/7adbe121223f7e32ab7e2592a72093f80f4e11a8/

giturl: https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
branch: linux-5.10.y
commit hash: 7adbe121223f7e32ab7e2592a72093f80f4e11a8
origin: maestro
test start time: 2026-05-23 12:15:07.250000+00:00

Builds:	   40 ✅    2 ❌    0 ⚠️
Boots: 	   36 ✅    0 ❌    4 ⚠️
Tests: 	  315 ✅   78 ❌   44 ⚠️

### POSSIBLE REGRESSIONS

  No possible regressions observed.


### FIXED REGRESSIONS

  No fixed regressions observed.


### UNSTABLE TESTS
    
Hardware: bcm2711-rpi-4-b
  > Config: defconfig+lab-setup+kselftest
    - Architecture/compiler: arm64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a11a1965bf5d05c9744e875
      history:  > ⚠️  > ✅  > ✅  > ✅  
            
Hardware: beaglebone-black
  > Config: multi_v7_defconfig
    - Architecture/compiler: arm/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a11a07c5bf5d05c9744e2cd
      history:  > ✅  > ⚠️  > ✅  
            
Hardware: qemu-x86_64
  > Config: x86_64_defconfig+lab-setup+x86-board+kselftest
    - Architecture/compiler: x86_64/gcc-14
      - boot
      last run: https://d.kernelci.org/test/maestro:6a11ade45bf5d05c9744f85e
      history:  > ✅  > ⚠️  > ✅  
            



This branch has 2 pre-existing build issues. See details in the dashboard.

Sent every day if there were changes in the past 24 hours.
Legend: ✅ PASS   ❌ FAIL  ⚠️ INCONCLUSIVE

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org

