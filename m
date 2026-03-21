Return-Path: <stable+bounces-227639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACaANqnhvWnmDAMAu9opvQ
	(envelope-from <stable+bounces-227639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 01:09:13 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C7BD2E2761
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 01:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CA27301BC12
	for <lists+stable@lfdr.de>; Sat, 21 Mar 2026 00:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC7421CC59;
	Sat, 21 Mar 2026 00:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="UFF0HC/H"
X-Original-To: stable@vger.kernel.org
Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E381B4138;
	Sat, 21 Mar 2026 00:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774051729; cv=pass; b=a6QbilXi8jXwFAZpBMBxam2GNmX0BcVwehr3mSk1kU8OB8hU2qUZ86QCRwY7D9ajn3/eaSCgoHe2PqAD8AFM9aExVHEOSFmOIwogL1H+azniATRCLQE6SIUji6LAp+C37ROBmm0LIf8N8yIct79BW1ZuI9TVwGXHt4qjNJF06ow=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774051729; c=relaxed/simple;
	bh=SFp00vq4JyybMAbM+n/SB4PkqRpGAMby83rbwLEWzc0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GMRx597vOz86jSNQZP9ClNl1K4ibiY2QfRE3SP6ofeT8nUED9kLkW45rtvJtO08RjxIN1OKlmIjZbSqkb/2YpkOVYbzCgLSDgX5m3zgDaFb3kQFXuBBkaw8IhPD7vjYW1Xp6pVwbt91XovZuTZSBHYEyxn24eHJOGjr4J8Tsi5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=UFF0HC/H; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
ARC-Seal: i=1; a=rsa-sha256; t=1774051712; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=Ot3VSSaZu3w0EJk2kNRqcxvTnv53LkYqqERkISePoWgewkbjZbAwV3h0F+F+2zyIHcUe8XdLO9DK7O+im/Ktl2D8d51WLN1ROhFKwy3lLynJ5tQ3ywwRNMpqTV42JLsWSYbg+FEomTozA2NUoNR++OWHaA7fI8CEZtWMJ1kwJVc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774051712; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=pBghYJ/F/Pt0HxiS5MRMUDhDiTzAi0jLjVNvoL6gXyA=; 
	b=dlUw2tbsGohlZLAfHNQr8yE62OnPQB7Q+BDktR6gZaNFmD/TgTERvxcf6/9AngvudjSElPDlC1BltmoXAqvEs8EtdJLD9VHSmAv/oVIK5xY+ra94dA73UUWF8MR6yglL8VyzxQSD1TSBsCWSkVXFyQClHHXafhukEfbj+nAufuY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774051712;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=pBghYJ/F/Pt0HxiS5MRMUDhDiTzAi0jLjVNvoL6gXyA=;
	b=UFF0HC/Hr4z/DfDIlT35DNLMP6jx54vRe9xKtJZYe049HIW4Ht9JEjtUrwUyGx0b
	uS9q/yTnXxipvs+OOCfijUZrsVAAowtga3hS6R0ykOSMp51R14d2ifptodqEyWOaket
	6rhjvNL1gHASnDAcY0NE7ga7zSDaugVPDaUCs5Xw=
Received: by mx.zoho.eu with SMTPS id 1774051710629882.7436884050414;
	Sat, 21 Mar 2026 01:08:30 +0100 (CET)
Date: Sat, 21 Mar 2026 00:08:29 +0000
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>
CC: Andrew Morton <akpm@linux-foundation.org>, damon@lists.linux.dev,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_mm/damon/sysfs=3A_fix_param=5Fct?=
 =?US-ASCII?Q?x_leak_on_damon=5Fsysfs=5Fnew=5Ftest=5Fctx=28=29_failure?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260321000255.102944-1-sj@kernel.org>
References:  <20260321000255.102944-1-sj@kernel.org>
Message-ID: <6902CC73-84EE-4C1D-9FC6-F54C7C378387@objecting.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spamd-Result: default: False [-0.95 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[objecting.org,quarantine];
	R_DKIM_ALLOW(-0.20)[objecting.org:s=zmail];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227639-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[objecting@objecting.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[objecting.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,objecting.org:dkim,objecting.org:mid]
X-Rspamd-Queue-Id: 3C7BD2E2761
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 21 March 2026 00:02:54 GMT, SeongJae Park <sj@kernel=2Eorg> wrote:
>Apparently this series is only by a mistake, and therefore a new version =
[1] is
>posted=2E  So I will skip this series and review the new version=2E  Let =
me know if
>anything is wrong=2E
>
>[1] https://lore=2Ekernel=2Eorg/20260320163559=2E178101-1-objecting@objec=
ting=2Eorg
>
>
>Thanks,
>SJ
>
>[=2E=2E=2E]


Only the numbering was wrong, like no 1/3 2/3 etc=2E Im a bit of a perferc=
tionist so i nitpicked it

V/R

Josh Law

