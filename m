Return-Path: <stable+bounces-249729-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oEz+DywmDWo8twUAu9opvQ
	(envelope-from <stable+bounces-249729-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:10:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3F4587134
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C49D30492A1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 03:08:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CABDE331A76;
	Wed, 20 May 2026 03:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="OKuDqMWR"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-155.mail.qq.com (out203-205-221-155.mail.qq.com [203.205.221.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597632E73E;
	Wed, 20 May 2026 03:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779246525; cv=none; b=F2zAnG9+EjvIJk8JRHONBAd1/3SNTIVD68By882XKuCb7pXImhXq+EuJ0G/uMQicjpWuu8vTxots6vals4jWciQfNglx+d5JyFfAtDvD82qu/dFNRQInZF6DYRbrFUGjTewKRWy5NlHTm/ein6sDQaZd7r63VTfnkhXPOJHYyYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779246525; c=relaxed/simple;
	bh=ipSFebB039PKB7pOSxl7GRLTSXy9lTwCUy2obuL5GNU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version:Content-Type; b=ew9UL8UY4Q6XP36frZgDkGNF6JNHdmkE3OlNBO8nrw8limyOYxA52hjOkEfPEUpF2Y5+OE4PgtRMts6Oz6zfcPAp7zHwbkk2j786ojEwg1ymy8hSNwkaQ+MhFP/3aPTdkyJLthCEQi1jgl4vM+/pXryLESMTUOu0HGSHzCQUOlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=OKuDqMWR; arc=none smtp.client-ip=203.205.221.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1779246513;
	bh=z9WE2M4i+oa7eJUW/aev1vHkjcVSJfZcXKvFNPR69jE=;
	h=From:To:Cc:Subject:Date;
	b=OKuDqMWRx67/WJ9/Hmfe45Kye1J1SuSBPdyoC46IXtamdcJXfYSsXZKJwQHSkVIg/
	 +Xvfrdl354xu8e2K3hL7UZ2EXWYlpp1WQQ1LW8q22f0XFe6g8nO+OjFfWIo/IQnXcn
	 3Sa8lIC9+jIZyyw8lVLTkbtbJS9JVRveNMsW4RLo=
Received: from China-team ([47.95.114.252])
	by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
	id 215A5014; Wed, 20 May 2026 11:08:21 +0800
X-QQ-mid: xmsmtpt1779246501t1fs71ks4
Message-ID: <tencent_5129AC5B71AC600A1B0C69236AF83EA22509@qq.com>
X-QQ-XMAILINFO: Me8mHstNM5a8oSNOyakBQYA2IFx9mHB4QFl3I0nObvGt34lTVHRWEaxsDlKema
	 zYOfMMy8KqljGnNMJdsljgNIAU3Rm4Tzrbl7PWDx6El8Z+JokfpI6PZsfMJUCRs8lvH+JKq6Fl8f
	 o2EfjtItXvqtCd7lpEj8Araw3s3l+Kz70JtcSKjUhJLr2j1qVqdmDe7PwTeK+q9nrjW04ufqVQqc
	 /rzZzBgAFXp9vYsQHsVBucK+/9QttMElSTSZUyS0OKD0jFyyQB2rXaKDt14Eiu7DG9YxcdwIK+Op
	 TMPp9BYpvfqrNsfuEArJg4Dk00XAbRb+rFa70saWCqeWI3Szat+1ME6hmtIg3e0/aLfaBfb3Tl4q
	 sGOzatLTDXyfg8x/8vf9spl+Ki4sbMggpQ0H/Socc3SjWYgvU/x6WB2bv++6ueV+SgyobFCvtivH
	 3m9Mjr/soinUjMZ8EFyeh8dbUsqyf1VYRg+5T0E8bciy7kZqsH+KJgwYPecIcEgGmJx6FaPIe2uy
	 islNzoqI9v2vgYA5bb0L1o06s+T3VHBNPLTBu/H4b4n/KADOnrtzFlHvvRodfbDhnQPDHzJArqFC
	 e6F5B4JG/UAPL69F1SGiU8UZnykRMqkAFF+ZRDUOHzl62dx2GMKlUN3kr3dSSjSLPuZED61YjuPF
	 EP2u+2IS8SfJxMR0FywxkUf2LmehzLf1d8wkb+zctnwnlsEY47fEcDIW1Q4oawpjwQPO+jwpPQsy
	 RGubmsiIMRiGR68XGPhwRjvJ9YZ+stUPzH5mxdJfgkKHOLqdOMVZ3vop3789OyUFiKRXoWbK5aGl
	 e/pmB6cIv6c/QqUOTi7Jz/1QpBTwB0IvNBDmpHaLW4Qyeeiy/YSqAkcwqpkrVN1/MO/3nMIul67J
	 l26X6TKw7x5p4BhfoRR3pwUUStOT1hH1/+cFjUDjZxjhkJYau4f1+NoTFwB6lG7SPJW7P6tJC809
	 rZv1B7MUq+gHJs+bbdzgjYSOZACHNAocT9ULVo4HNVMtzGYHfwilW/DAS3VPWYaATkVgSnyHcw5o
	 JlASQxZHjizmzUpeyKPnsUATCm2TY=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
From: Alva Lan <alvalan9@foxmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	pierre-louis.bossart@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	broonie@kernel.org,
	alvalan9@foxmail.com,
	ranjani.sridharan@linux.intel.com,
	liam.r.girdwood@intel.com,
	mateuszx.redzynia@intel.com
Subject: [PATCH 6.6.y v2 0/3] ASoC: SOF: Intel: hda: Fix NULL pointer dereference in v6.6
Date: Wed, 20 May 2026 11:07:59 +0800
X-OQ-MSGID: <20260520030802.27966-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[foxmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[foxmail.com:s=s201512];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249729-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,linux.intel.com,kernel.org,foxmail.com,intel.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[foxmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alvalan9@foxmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[foxmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[foxmail.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,qq.com:mid]
X-Rspamd-Queue-Id: AB3F4587134
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

v1->v2: add two prerequisite patches.

This series backports a fix for a NULL pointer dereference in
hda_dai_get_ops() to the 6.6.y stable branch.

The fix (patch 3/3) adds a NULL check for the widget before
dereferencing it. However, it depends on two prerequisite patches that
modify the code context in hda_select_dai_widget_ops():

  Patch 1/3: daa09d0615ce ("ASoC: SOF: Intel: hda-dai: remove dspless special case")
  Patch 2/3: 2065610b5ddd ("ASoC: SOF: Intel: hda-dai: add support for dspless mode beyond HDAudio")
  Patch 3/3: 16c589567a95 ("ASoC: SOF: Intel: hda: Fix NULL pointer dereference")

All three patches apply cleanly to v6.6.140 without adjusting the context.


Pierre-Louis Bossart (2):
  ASoC: SOF: Intel: hda-dai: remove dspless special case
  ASoC: SOF: Intel: hda-dai: add support for dspless mode beyond HDAudio

Ranjani Sridharan (1):
  ASoC: SOF: Intel: hda: Fix NULL pointer dereference

 sound/soc/sof/intel/hda-dai.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

-- 
2.43.0


