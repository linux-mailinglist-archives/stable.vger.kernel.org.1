Return-Path: <stable+bounces-274742-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UJDcFYcnV2pkGQEAu9opvQ
	(envelope-from <stable+bounces-274742-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 08:24:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D0D75B051
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 08:24:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=chenxiaosong.com header.s=key1 header.b=akO7I3yK;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274742-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-274742-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=chenxiaosong.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7DC133024E2C
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 06:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13708320A14;
	Wed, 15 Jul 2026 06:22:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5B0301704
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 06:22:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784096538; cv=none; b=D1BPyLUTcFq2QxK8JsREiFiEyRS06X+RJUe3BVbuqKkM7QNmwpHIXPaLN8WP5pFbHoU2a58Gy8HtX2GqiiW8XwVuQ0id1ah+MVqc4hC5CzsLTyCb9XemGSvKXtIMC1c/vYQhzrb9yYIAR3SrQmo/PBymX+fMGnAD9fCEJ4+cbg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784096538; c=relaxed/simple;
	bh=tMmYPuHq1TlWdikDZSCv0oAeVAd1+jF9vCMR05MaJYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jdntC8mvGdSbBQ4h9UM9cx+JwuNXW8txkMSZfFBDQs0QogcbnKRIUzCAKWsfQ9I4ys7wMuhmFNHuUNeMbP7N6KSXwp4HW7G5mpIgQtuX3r2mZWSEQvUL9zuKWciMGBTTDWuASzjIox3BfV5kKiUs2P+4WLHAChhEVOBnnKTpTD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=akO7I3yK; arc=none smtp.client-ip=91.218.175.189
Message-ID: <afa8dd4e-eac0-47f4-9c08-c9fd278a37a9@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1784096531;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7x/HPKlo+USj4BpsCmStRoC33Qynj1Q2IqK9qpyL+F8=;
	b=akO7I3yK/m5XvQrsrf5PnYfovBMoNkXOcdfYCan/l/C0DM3AXYmP9lkvxcsiBoGKPMiZca
	tjM7qEKANLCSWyW84LKBRnDgyYp+5qy9mneJ0T2F16zvBi2N8uiKDie2QVSQT/+PW9xVyj
	bQU5fr3kdlh6fmTTouO1LP8uhc2by2eNpd/K33h25nMDSrEnqGcs+o9Zo/RKyXav9pBrlR
	+eRs0o+MVFfZzIWGACcXScEr/ArVLkQhZ0MTIGPsbCIXkxD2GBworMdAwCuyZSivc8pxci
	RFFCyrR4iurkO4PVDhi/op4iqePnf8oX2QsLWKT8DR+jQ1bbeaKk3MqqDDZ1Aw==
Date: Wed, 15 Jul 2026 14:20:42 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: FAILED: patch "[PATCH] smb/server: do not require delete access
 for non-replacing" failed to apply to 6.1-stable tree
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linkinjeon@kernel.org, stfrench@microsoft.com, stable@vger.kernel.org
References: <2026071409-clamp-reminder-aacc@gregkh>
 <b5901dc2-0d5c-45ac-a817-81e2a3934131@chenxiaosong.com>
 <2026071515-dutiful-anthem-39fb@gregkh>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <2026071515-dutiful-anthem-39fb@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chenxiaosong.com,quarantine];
	R_DKIM_ALLOW(-0.20)[chenxiaosong.com:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-274742-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:linkinjeon@kernel.org,m:stfrench@microsoft.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[chenxiaosong@chenxiaosong.com,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong@chenxiaosong.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[chenxiaosong.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,chenxiaosong.com:email,chenxiaosong.com:dkim,chenxiaosong.com:url,chenxiaosong.com:from_mime,chenxiaosong.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62D0D75B051

Okay, my team will do it.

On 7/15/26 12:46, Greg KH wrote:
> Ok, so what does that mean?  Can you provide backported patches for
> these branches?

-- 
ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Chinese Homepage: https://chenxiaosong.com
English Homepage: https://chenxiaosong.com/en


