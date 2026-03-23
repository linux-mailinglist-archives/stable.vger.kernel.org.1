Return-Path: <stable+bounces-227901-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKexMA7twGm3OgQAu9opvQ
	(envelope-from <stable+bounces-227901-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:34:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7222EDA54
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 08:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B6C0300493D
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 07:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EAD35E529;
	Mon, 23 Mar 2026 07:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="aueLpHc3"
X-Original-To: stable@vger.kernel.org
Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E842BEC5E;
	Mon, 23 Mar 2026 07:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774251272; cv=pass; b=ksLCYzir8eyAcTQB592ERTpgQJMh4cikhGBA0+puXT7e1ZqE+YEEO+02FyehMu6dXlnCZbnUqr6ly6CzlcFh9hBao/kLDfDm+ZPr5JJx6rW2FVWPFyG4YOHlmqQyPwINZbncnxxdjBuQxvOL9ZRIAxSPI/Hzwr965fE78zAVt4U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774251272; c=relaxed/simple;
	bh=N03MwYZKfJyz/jISI55XQbpuxlLeDNyC93LJJN41uQE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Ju8rvopn3O39ahZ5TYC7ARYSS0ZRgQySmW0DH9+fATP+ePfrQupTF1+l09FGfPo+lCTIhwitPZW25f0jKf93xBYphQ+/Xp1lNQfuWL5iP1vmZWCiVSfDt5a0H+4wOl/+FueT68z7gfUVaCvHzlX/r68xEwD+iTcfwrNPDmOZYkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=aueLpHc3; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
ARC-Seal: i=1; a=rsa-sha256; t=1774251241; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=aLUnjvWbgEl7I0JC+aTZBN+fnPPMFfI8i2jdvaFHgh5TwmGuoWcUJl9PraU6SDZucBuH+quJLOxU4R220FB67UjVk5EKVdZ//jJ7oWwI25ucQdZBlKPBGjKsNzqympd2iJWQg5kT1xu6HFVCLSlvhmfy+6xt/lGt9p4ECl6ANdM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774251241; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=N03MwYZKfJyz/jISI55XQbpuxlLeDNyC93LJJN41uQE=; 
	b=UsIXLyFsu3TmM6YipQqXh4PLYMyOlC3w2LFD/AAP12265oYV9Z+/RVYn97TJcSx7wXjaBDwcP2kau/952bfAwxqCebMzM/AVtS/h2R5VuVYvieJYk3HEwvv8rG1mWVXgn11A4AHaBtsB379jY+rOv/AMjy2FWfPPOE0R7x9l/fg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774251241;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=Date:Date:From:From:To:To:CC:Subject:Subject:In-Reply-To:References:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=N03MwYZKfJyz/jISI55XQbpuxlLeDNyC93LJJN41uQE=;
	b=aueLpHc313GbcC2+GHpnpX7AB8MaxMKRGWEyBqVAqnnPpOPl3doxlTyG9LAMYlAl
	J48cJ90xKKPp0YBNUkAxvhIw5825eueORi81Hxh0sBxkVCxZYt1elHLjhnyW1NaKPgA
	/veyPTzho3WrAo4OferEZ8feGHBtzHo/vdrTJSnc=
Received: by mx.zoho.eu with SMTPS id 1774251240068390.417387203978;
	Mon, 23 Mar 2026 08:34:00 +0100 (CET)
Date: Mon, 23 Mar 2026 07:33:59 +0000
From: Josh Law <objecting@objecting.org>
To: Markus Elfring <Markus.Elfring@web.de>, SeongJae Park <sj@kernel.org>,
 damon@lists.linux.dev, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>
CC: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/3=5D_mm/damon/sysfs=3A_fix_param=5F?=
 =?US-ASCII?Q?ctx_leak_on_damon=5Fsysfs=5Fnew=5Ftest=5Fctx=28=29_failure?=
User-Agent: Thunderbird for Android
In-Reply-To: <89ab7e7b-ad61-4881-bceb-781481857d3d@web.de>
References: <20260321175427.86000-2-sj@kernel.org> <89ab7e7b-ad61-4881-bceb-781481857d3d@web.de>
Message-ID: <BDDAE837-48DD-4FF8-B7E3-AC0030AF5C9F@objecting.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-227901-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[web.de,kernel.org,lists.linux.dev,kvack.org,linux-foundation.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[objecting.org:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[objecting@objecting.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bootlin.com:url]
X-Rspamd-Queue-Id: 6C7222EDA54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 23 March 2026 07:28:59 GMT, Markus Elfring <Markus=2EElfring@web=2Ede> =
wrote:
>> When damon_sysfs_new_test_ctx() fails in damon_sysfs_commit_input(),
>> param_ctx is leaked because the early return skips the cleanup at the
>> out label=2E Destroy param_ctx before returning=2E
>
>Will it become helpful to use another label accordingly?
>https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvalds/linux=2Egit/=
tree/Documentation/process/coding-style=2Erst?h=3Dv7=2E0-rc5#n526
>https://elixir=2Ebootlin=2Ecom/linux/v7=2E0-rc4/source/mm/damon/sysfs=2Ec=
#L1506-L1537
>
>Regards,
>Markus



Markus these patches are already merged=20


V/R


Josh Law

