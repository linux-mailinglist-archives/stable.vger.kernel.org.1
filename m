Return-Path: <stable+bounces-233714-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBaxGVVX1Wmu4wcAu9opvQ
	(envelope-from <stable+bounces-233714-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 21:13:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CC63B347E
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 21:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D795302B3B7
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 19:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628FE34CFA1;
	Tue,  7 Apr 2026 19:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kcore.it header.i=@kcore.it header.b="hs8NoClG"
X-Original-To: stable@vger.kernel.org
Received: from spark.kcore.it (spark.kcore.it [49.13.27.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DBE3DBA0;
	Tue,  7 Apr 2026 19:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.13.27.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775589194; cv=none; b=GkaJAkmdnB/ezUkf2t56AJRz0gtruAXxudUfTBtTELoCBwcplCJ0uJVVrqNZbBjmrB4jkgT8wA0l7Eo4ak/4N7U4BdGuy1ZUh1YeInC/3+tGJ/DDCBs5/3uts0qyupHiiiYE/Tau2YVQccXKKqvcmmdODy2z4W1w7oRQhb2bb2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775589194; c=relaxed/simple;
	bh=OVKkSVKoQrS169CFG8B8konCXxxeRqxmXu9wnbe6Sok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:References; b=RjuObehZmeBZuVoKcZRKmHdFDSo3CdoJJcVg+AFkEkWGgrq2NZeDvQnx2IVrjw2pZFO2frJ/d0yLvmRpJC2XHeoh9XtRxSyJbP6dQQf4pSdj4V9aO34WSDfZ75tKl8pN2REvgOg5PLerqRezu9O+Ds1Z6SpbjOJ5A6d62TFQNq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kcore.it; spf=pass smtp.mailfrom=kcore.it; dkim=pass (1024-bit key) header.d=kcore.it header.i=@kcore.it header.b=hs8NoClG; arc=none smtp.client-ip=49.13.27.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kcore.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kcore.it
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kcore.it;
	s=spark; h=References:In-Reply-To:Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OVKkSVKoQrS169CFG8B8konCXxxeRqxmXu9wnbe6Sok=; b=hs8NoClGTSEy4o+/lFEOWW9eTA
	xAWFWH+yBcZt9dZq3MI+y0D4uNkznVbOGGvm8gB8ashL51d8p4zD6gTRXlpu7IAAyfJSVsosT1ZRK
	i5sYQVv9lgNIK1jCTQlzCab1/0kFtV+viSsK3BQHJ70C5/PCZvCYAynZ97e/bDAcOWu0=;
Received: from mnencia by spark.kcore.it with local (Exim 4.96)
	(envelope-from <mnencia@kcore.it>)
	id 1wABr5-007Daj-0e;
	Tue, 07 Apr 2026 21:12:55 +0200
Date: Tue, 7 Apr 2026 21:12:55 +0200
From: Marco Nenciarini <mnencia@kcore.it>
To: sakari.ailus@linux.intel.com
Cc: linux-media@vger.kernel.org, bingbu.cao@intel.com,
	tian.shu.qiu@intel.com, mchehab@kernel.org,
	andriy.shevchenko@linux.intel.com, stable@vger.kernel.org
Subject: Re: [PATCH v3] media: intel/ipu6: Improve DWC PHY HSFREQRANGE band
 selection for overlapping ranges
Message-ID: <adVXNx8hW4CAY3O5@spark.kcore.it>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260401162547.1597975-1-mnencia@kcore.it>
References: <20260401162547.1597975-1-mnencia@kcore.it>
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[kcore.it:s=spark];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kcore.it:-];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-233714-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kcore.it];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mnencia@kcore.it,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.935];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,spark.kcore.it:mid]
X-Rspamd-Queue-Id: C4CC63B347E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sakari,

Gentle ping on this. v3 addresses all your feedback from v2 (u16 for
best, dropped exact default_mbps match, early break when min exceeds
the requested rate).

Andy also had a look and had no requested changes.

Do you have any further comments, or is this good to go?

Thanks,
Marco

