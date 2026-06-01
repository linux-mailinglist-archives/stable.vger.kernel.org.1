Return-Path: <stable+bounces-259640-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4MIzJNfJHWrHeQkAu9opvQ
	(envelope-from <stable+bounces-259640-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 20:05:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB6E623B30
	for <lists+stable@lfdr.de>; Mon, 01 Jun 2026 20:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BEDB305A270
	for <lists+stable@lfdr.de>; Mon,  1 Jun 2026 17:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D803E1232;
	Mon,  1 Jun 2026 17:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b="ZErSVjjG"
X-Original-To: stable@vger.kernel.org
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5491B36B059
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 17:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.12.53.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336631; cv=none; b=r7tB+LHfZtUpd3Skbftj23YdewY8ukO4Kru0aOmws+jzCg3tHLiwhZjmvJnxosiHR9V1j1Uh/YeGv2DVHi/uK5gYhV6Gbv8srdXkke+IwPNOUUwSjcPCr8oPTj0kE0C1CswUkYq+XgyDb1JZ6Vk4SxKahlDm1OakJ2HE3uV07AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336631; c=relaxed/simple;
	bh=qnGyM4y8G4axpE661OgJsVEo4H4WjYNT9UoSJD/KAFM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AsSvTuSTOFoJ9cIR5XcSL/Hq86EY+NtTX2MJyZHuF8CBEH5ILR7KnJFmmXG+8pSFPQvOchuzUOYaTSmU43WHeDeH5tha/jM0kBCqgJ4HlHAgTNsXR+WH2Kk01nPe4vjvMM4sI7zF61ic54YSbr25PHX/fN34gdNpdGbfcfWYLuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de; spf=pass smtp.mailfrom=amazon.de; dkim=pass (2048-bit key) header.d=amazon.de header.i=@amazon.de header.b=ZErSVjjG; arc=none smtp.client-ip=52.12.53.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1780336630; x=1811872630;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=qnGyM4y8G4axpE661OgJsVEo4H4WjYNT9UoSJD/KAFM=;
  b=ZErSVjjG+NhQtSyVhtrPluG2NuH03YuFbyMsJYY1wPsBZ/SOrH7Hu6pa
   Rx+JeC0oFtp2RfzDIPHELdeAIhrN4HC4pUTRa3DMeS0JdnxtJRHwh7cST
   ObKpYHWVt9x1wiV7WqrINPhXmpyUtvtcWvYx6knuEmvhCSr4EBtwQjsdb
   MgENhhFHskovSS5pjE9frB8RJj2CQ84IzCsjZ6uo2Rpik1VCKcDABhv9Q
   K0/DEEMCh5X1TJ9eRYIK+rrLMEW3+MpHm2J0v2RM6EtuAnZ1AoUjIh2un
   t12g/0CqY3A9SPnctsVKlcrNvu+mpRwZHkEfILo6oXMlpsTQDPRX3VuGG
   g==;
X-CSE-ConnectionGUID: SFw8DfmuQb6AGOjIYh9Kww==
X-CSE-MsgGUID: cD6XBXa4T5yC0rTaFKrG/A==
X-IronPort-AV: E=Sophos;i="6.24,181,1774310400"; 
   d="scan'208";a="20740828"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 17:57:07 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.182:18139]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.73:2525] with esmtp (Farcaster)
 id 885207e2-7691-46f5-8ace-38b01c377a96; Mon, 1 Jun 2026 17:57:06 +0000 (UTC)
X-Farcaster-Flow-ID: 885207e2-7691-46f5-8ace-38b01c377a96
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 1 Jun 2026 17:57:06 +0000
Received: from dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com.amazon.de
 (10.253.107.175) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37; Mon, 1 Jun 2026
 17:57:05 +0000
From: Mahmoud Nagy Adam <mngyadam@amazon.de>
To: <stable@vger.kernel.org>
CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <nagy@khwaternagy.com>
Subject: Backport "net/sched: cls_fw: fix NULL dereference of \"old\"
 filters before change()"
Date: Mon, 1 Jun 2026 19:57:04 +0200
Message-ID: <lrkyqmrxe16vj.fsf@dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.de,quarantine];
	R_DKIM_ALLOW(-0.20)[amazon.de:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amazon.de:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259640-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mngyadam@amazon.de,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dev-dsk-mngyadam-1c-cb3f7548.eu-west-1.amazon.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amazon.de:dkim];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9BB6E623B30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


Hello,

Could we backport the follow up fix patch 65782b2db732 ("net/sched:
cls_fw: fix NULL dereference of "old" filters before change()") to
stable trees. The commit is fixing faeea8bbf6e9 ("net/sched: cls_fw: fix
NULL pointer dereference on shared blocks") which got backported to
5.10->6.18.

We've tested it with our AL Kernel testing over EC2 instances for
kernels 5.15->6.18.

Regards,
Mahmoud Nagy Adam

ps: I'm following option 2 approach:
https://docs.kernel.org/process/stable-kernel-rules.html#option-2
If you think it's better to send the patches I could do that (option 3).



Amazon Web Services Development Center Germany GmbH
Tamara-Danz-Str. 13
10243 Berlin
Geschaeftsfuehrung: Christof Hellmis, Andreas Stieger
Eingetragen am Amtsgericht Charlottenburg unter HRB 257764 B
Sitz: Berlin
Ust-ID: DE 365 538 597


