Return-Path: <stable+bounces-211257-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6AgNFvlVcmkJiwAAu9opvQ
	(envelope-from <stable+bounces-211257-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:53:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5483F6A60B
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 17:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0CD3A3004078
	for <lists+stable@lfdr.de>; Thu, 22 Jan 2026 16:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2678D47DFB5;
	Thu, 22 Jan 2026 16:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lio96.de header.i=@lio96.de header.b="V3ePfpox";
	dkim=pass (2048-bit key) header.d=lio96.de header.i=@lio96.de header.b="Z75pYkmQ"
X-Original-To: stable@vger.kernel.org
Received: from er-systems.de (er-systems.de [162.55.144.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD10492519
	for <stable@vger.kernel.org>; Thu, 22 Jan 2026 16:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.55.144.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097840; cv=none; b=VIs0rIZaq0kZmh3CjXPy/VYU/rNusCg5yS1N9nfar9tjvyqXIxo4MfqLZuhlV8vvW5K1rKz1Y10gw1ukmzb6v2xNUAzTznEIcam0iCO0d+9D0a23fQos7Oa6RQgI/TOtpUHguBffWG2BDFvEVKveGGUfV4P7ehAi3yL9cKB6oi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097840; c=relaxed/simple;
	bh=u8A7KoQf7hfe6FsBIih8/uvyL487s/KjWJzVBHGnyQI=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=gWXaGhzQ/tpfmpIMCA05HxknNATyOdIHSgV8ruKL8c37XlaWUVlseG/ix3rLu8YIbn+G9nMP+QqSIpE9r4qma8JqjRIlOu3fV4zX9FweskYGny9NeC8q8H8eRY0flUiDNC92L3tGNwkkZLfMxsfHii/8xW+NGA0QjMU20IrBDIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lio96.de; spf=pass smtp.mailfrom=lio96.de; dkim=pass (2048-bit key) header.d=lio96.de header.i=@lio96.de header.b=V3ePfpox; dkim=pass (2048-bit key) header.d=lio96.de header.i=@lio96.de header.b=Z75pYkmQ; arc=none smtp.client-ip=162.55.144.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lio96.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lio96.de
Received: from localhost.localdomain (localhost [127.0.0.1])
	by er-systems.de (Postfix) with ESMTP id 9D9F7EC0058;
	Thu, 22 Jan 2026 16:55:06 +0100 (CET)
Authentication-Results: er-systems.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lio96.de;
	s=20251201; t=1769097308;
	bh=m4ZYfdkn4WT9yNlWbJdGjSPtRqI/01b5fEyn3Dbl1IU=;
	h=Date:From:To:Subject:From;
	b=V3ePfpoxeyBSDhE8FdMTVwoJ23RrAksPGUIJJD8/Q8inV++4KWP2iiBvQZ6aXKWWy
	 EAMqtIaHCWyRtLSGz9N7RM38+kQY2sojrlrGQmVBGLYyBPHgpXRR83kuHkHePLJa22
	 aN55tBkwq6rg3PG2rsYpeTBK6ucJaDl662Xz2C1rrxwsdwdLZWbyIEWCqWYWsN6zlH
	 mvYzyTRyzgatycqrAZtvWbDK95UTdmhDFFBjvFcegb3WPQFtnbX/LL1VbNKE+VgQtO
	 Mi36aDnEpNg40piptHyt5+W83l5xsiUMjvLMyee6HDF739Ptgs964WdvP7R7xTnJwI
	 Sq5F7hJhOTn9g==
X-Spam-Level: 
Received: from localhost (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by er-systems.de (Postfix) with ESMTPS id E4EC4EC0057;
	Thu, 22 Jan 2026 16:55:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lio96.de;
	s=20251201; t=1769097305;
	bh=m4ZYfdkn4WT9yNlWbJdGjSPtRqI/01b5fEyn3Dbl1IU=;
	h=Date:From:To:Subject:From;
	b=Z75pYkmQTT+MFHzi6aTJWTaLcpu3sffRy+UF3iRWeQRxZbyFfdesBLfbWCTRBDaTH
	 0fVCbglbAGvDKzQkuZp6Voxkr8jVB1uDyjyclg6GGTRMQ2HUS4YByih9asAFEAXm78
	 oOR19ovKZ/0CkGQ4yUwik1IWLyMI3ol/+Xx5+k250YXh2Klin9OPrcPNtE2YQoX64t
	 dhlPQkRQDAh/bHHcDe86XxoAkFtbqkVJU7QKG2t3cYvUqXujRjsORClqXMxpCOieiU
	 PSMUyanXJZLqKH8rJMfjtbwELf2Ym7ClSalu9nqTqn82qZYoU/QycfeEDTD9o0eVhS
	 SqUwc2sjokhSQ==
Date: Thu, 22 Jan 2026 16:55:04 +0100 (CET)
From: Thomas Voegtle <tv@lio96.de>
To: Leo Yan <leo.yan@arm.com>, Sasha Levin <sashal@kernel.org>, 
    stable@vger.kernel.org
Subject: Building perf is broken in linux-6.6.y
Message-ID: <3a44500b-d7c8-179f-61f6-e51cb50d3512@lio96.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="933399184-895039094-1769097305=:6856"
X-Virus-Status: No
X-Virus-Checker-Version: clamassassin 1.2.4 with clamdscan / ClamAV 1.5.1/27888/Thu Jan 22 08:25:13 2026
X-Rspamd-Status: No, score=0.90
X-Spamd-Bar: /
X-Rspamd-Result: default: False [0.90 / 1000.00];
	CTYPE_MIXED_BOGUS(1.00)[];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_ONE(0.00)[1];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3]
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[lio96.de,reject];
	R_DKIM_ALLOW(-0.20)[lio96.de:s=20251201];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211257-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	DKIM_TRACE(0.00)[lio96.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tv@lio96.de,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linaro.org:email,arm.com:email]
X-Rspamd-Queue-Id: 5483F6A60B
X-Rspamd-Action: no action

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--933399184-895039094-1769097305=:6856
Content-Type: text/plain; format=flowed; charset=ISO-8859-7
Content-Transfer-Encoding: 8BIT


Hello,

building perf is broken for me since Linux 6.6.119.


linux-stable-rc/tools/perf# make perf NO_JEVENTS=1 NO_LIBTRACEEVENT=1
   BUILD:   Doing 'make -j12' parallel build
   HOSTCC  fixdep.o
   HOSTLD  fixdep-in.o
...
...
   CC      tests/sample-parsing.o
   CC      util/intel-pt-decoder/intel-pt-pkt-decoder.o
   CC      util/perf-regs-arch/perf_regs_csky.o
   CC      util/arm-spe-decoder/arm-spe-pkt-decoder.o
   CC      util/perf-regs-arch/perf_regs_loongarch.o
In file included from util/arm-spe-decoder/arm-spe-pkt-decoder.h:10,
                  from util/arm-spe-decoder/arm-spe-pkt-decoder.c:14:
/local/git/linux-stable-rc/tools/include/linux/bitfield.h: In function 
¡le16_encode_bits¢:
/local/git/linux-stable-rc/tools/include/linux/bitfield.h:166:31: error: 
implicit declaration of
function ¡cpu_to_le16¢; did you mean ¡htole16¢? 
[-Werror=implicit-function-declaration]
   ____MAKE_OP(le##size,u##size,cpu_to_le##size,le##size##_to_cpu) \
                                ^~~~~~~~~
/local/git/linux-stable-rc/tools/include/linux/bitfield.h:149:9: note: in 
definition of macro
¡____MAKE_OP¢
   return to((v & field_mask(field)) * field_multiplier(field)); \
          ^~
/local/git/linux-stable-rc/tools/include/linux/bitfield.h:170:1: note: in 
expansion of macro
¡__MAKE_OP¢
  __MAKE_OP(16)
...


Quick bisect showed this:

linux-stable-rc/tools/perf# git bisect bad
64378caea949d24f479bc809f9890cba683bb131 is the first bad commit
commit 64378caea949d24f479bc809f9890cba683bb131 (HEAD)
Author: Leo Yan <leo.yan@arm.com>
Date:   Tue Mar 4 11:12:35 2025 +0000

     perf arm-spe: Extend branch operations

     [ Upstream commit 64d86c03e1441742216b6332bdfabfb6ede31662 ]

     In Arm ARM (ARM DDI 0487, L.a), the section "D18.2.7 Operation Type
     packet", the branch subclass is extended for Call Return (CR), Guarded
     control stack data access (GCS).

     This commit adds support CR and GCS operations.  The IND (indirect)
     operation is defined only in bit [1], its macro is updated 
accordingly.

     Move the COND (Conditional) macro into the same group with other
     operations for better maintenance.

     Reviewed-by: Ian Rogers <irogers@google.com>
     Reviewed-by: James Clark <james.clark@linaro.org>
     Signed-off-by: Leo Yan <leo.yan@arm.com>
     Link: 
https://lore.kernel.org/r/20250304111240.3378214-8-leo.yan@arm.com
     Signed-off-by: Namhyung Kim <namhyung@kernel.org>
     Stable-dep-of: 33e1fffea492 ("perf arm_spe: Fix memset subclass in 
operation")
     Signed-off-by: Sasha Levin <sashal@kernel.org>

  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c | 12 +++++++++---
  tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h | 11 ++++++++---
  2 files changed, 17 insertions(+), 6 deletions(-)


Is that already known? Am I missing something here?


            Thomas


--933399184-895039094-1769097305=:6856--


