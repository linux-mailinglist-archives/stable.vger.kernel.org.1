Return-Path: <stable+bounces-243877-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBpHCvXN+Gkj1AIAu9opvQ
	(envelope-from <stable+bounces-243877-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 18:48:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F284C195C
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 18:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 730983028B26
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 16:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B73E3E1D1D;
	Mon,  4 May 2026 16:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i9FcFhyZ"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CB33E0233
	for <stable@vger.kernel.org>; Mon,  4 May 2026 16:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777913325; cv=none; b=s8AqK4+ubkLCOz8QkboooasIniYUGa/E8UnikHMLlClbrL29CpEyD5/cFgwnjWeu2t+1nDvu6ThMfoFJVWUHi0awiTpeuw2nVVmGC53Yz+FpsPLk1+kdiQSbdWmXO8owmDAvH0N6s5UHa1fm1ufU7p/uaElwOmxyL39aADeF4SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777913325; c=relaxed/simple;
	bh=GWq0yfjmV1xz9YNGL1RbVnlQ2R5Ai4KdNScNgP+4bco=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=DM7bwVRF8S7s5IrKe1a7ICFU0c5RLyiy5fTquZoN9+hz88JcmA8EKrDVyzwdvpjiuxrGzHtzjB4tNP+76k+9UBKHGEDSCNgOgFVzeoGbbnD5eqxpWalizHZtN/vJQAAMVdOSHceM0/2tUCF1Py3mh6roGF9Sn3xLkiY1Ba6gtNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i9FcFhyZ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 04 May 2026 18:48:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777913311;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5BwzgSdCRKq677PYNLuul7DfsefkneOrh3lBdxZDCcM=;
	b=i9FcFhyZz1ddqgNLSkj21CRP9Cbb94YK/vNEKxad8eZpbrSxM3xS74RQJh5okxg7EDmIhb
	uz/9gEdWE7L4zxQh9LD79ubTMtzKoBWfI0YtrNIW6RuMzdCostKp9Ndt++WIVpI+jwax/n
	sHMGovAv/KllmkjosOHh8+YaPwtwpwc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Luka Gejak <luka.gejak@linux.dev>
To: Greg KH <gregkh@linuxfoundation.org>, Feng Ning <feng@innora.ai>
CC: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, luka.gejak@linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v6=5D_staging=3A_rtl8723bs=3A_fix_hea?=
 =?US-ASCII?Q?p_buffer_overflow_in_cfg80211=5Frtw=5Fadd=5Fkey=28=29?=
In-Reply-To: <2026050417-monkhood-backless-4c3e@gregkh>
References: <20260413113224.5201-1-feng@innora.ai> <2026042626-tabloid-suitor-33c5@gregkh> <20260427111738.33069-1-feng@innora.ai> <2026050417-monkhood-backless-4c3e@gregkh>
Message-ID: <5035183D-9CC0-4D2F-90CA-3AA2B5AC480A@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 70F284C195C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-243877-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luka.gejak@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url,innora.ai:email,linux.dev:email,linux.dev:dkim,linux.dev:mid]

On May 4, 2026 4:12:44 PM GMT+02:00, Greg KH <gregkh@linuxfoundation=2Eorg>=
 wrote:
>On Mon, Apr 27, 2026 at 11:17:45AM +0000, Feng Ning wrote:
>> The cfg80211 framework allows userspace to specify a key sequence
>> counter (NL80211_KEY_SEQ) of up to 16 bytes via NL80211_CMD_NEW_KEY
>> netlink messages, but ieee_param=2Ecrypt=2Eseq is a fixed 8-byte buffer=
=2E
>> When cfg80211_rtw_add_key() copies the sequence counter via memcpy()
>> without checking seq_len, a heap buffer overflow of up to 8 bytes
>> occurs, overwriting bytes following seq within the same ieee_param
>> structure (key_len and the trailing key[] flexible array)=2E
>>=20
>> Cap the copy length at the buffer size using min_t()=2E
>>=20
>> Reviewed-by: Luka Gejak <luka=2Egejak@linux=2Edev>
>> Fixes: 554c0a3abf21 ("staging: Add rtl8723bs sdio wifi driver")
>> Cc: stable@vger=2Ekernel=2Eorg
>> Signed-off-by: Feng Ning <feng@innora=2Eai>
>> ---
>
>What about these review comments:
>	https://sashiko=2Edev/#/patchset/20260427111738=2E33069-1-feng@innora=2E=
ai
>
>Are they incorrect?
>
>And was this tested on real hardware?
>
>thanks,
>
>greg k-h

Hi Greg,
Is it better to let the driver attempt to function with a truncated=20
key sequence (via min_t), or should we explicitly reject the request=20
with -EINVAL to ensure we aren't installing a technically "broken" key
configuration? Which approach is more aligned with your preferences?
Best regards,
Luka Gejak

