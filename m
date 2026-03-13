Return-Path: <stable+bounces-225369-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sEIyIS9KtGk4kAAAu9opvQ
	(envelope-from <stable+bounces-225369-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 18:32:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 350EF288247
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 18:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 995BB3038006
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 17:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D714D3CEB81;
	Fri, 13 Mar 2026 17:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=guillain.net header.i=@guillain.net header.b="VcJ55QOy"
X-Original-To: stable@vger.kernel.org
Received: from 12.mo533.mail-out.ovh.net (12.mo533.mail-out.ovh.net [178.33.248.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110663CE4AD
	for <stable@vger.kernel.org>; Fri, 13 Mar 2026 17:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.33.248.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773423108; cv=none; b=WIs6EvCT6fUfhKwSWtpyA5v+g6XZ8QRich40f2Qw2YtbPLuK5cGzDdR8PjF0KNcZ49RKfore77VgLNNIMWR0PuyOLE0uT9ucIkWPBpepYlsQo8pN8iuOcWFkwInrFTNqFHy8mhycRC5XIHxWiLz76sdiODzQNzPO16XeNzxMpE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773423108; c=relaxed/simple;
	bh=o9C8GlaQINVvOBi8fo+i1hg6qc0ZSM+TwzJ3qKNbgeA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eN/tmXM0e/9PBfqaVIMyDcj/HRTn0Ntly60q0BWVWlphgxN+nZ4Ka+oNbdTeOUEY7CUWlUvGNMVv8KEmtJNAXXKz12MC8k6rrNJw0MRHzABnFanvf/QE+8qfbC3DXIlKmi34+SgasKfPRFxTANktX/QB0PFONOdwYe4dZKcm9mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guillain.net; spf=pass smtp.mailfrom=guillain.net; dkim=pass (2048-bit key) header.d=guillain.net header.i=@guillain.net header.b=VcJ55QOy; arc=none smtp.client-ip=178.33.248.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=guillain.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=guillain.net
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net [51.68.80.175])
	by mo533.mail-out.ovh.net (Postfix) with ESMTPS id 4fXWJ432gkz5yPV;
	Fri, 13 Mar 2026 17:12:20 +0000 (UTC)
Received: from director1.derp.mail-out.ovh.net (director1.derp.mail-out.ovh.net. [127.0.0.1])
        by director1.derp.mail-out.ovh.net (inspect_sender_mail_agent) with SMTP
        for <dsterba@suse.com>; Fri, 13 Mar 2026 17:12:20 +0000 (UTC)
Received: from mta11.priv.ovhmail-u1.ea.mail.ovh.net (unknown [10.110.37.222])
	by director1.derp.mail-out.ovh.net (Postfix) with ESMTPS id 4fXWJ40whfz5xTh;
	Fri, 13 Mar 2026 17:12:20 +0000 (UTC)
Received: from guillain.net (unknown [10.1.6.9])
	(Authenticated sender: jean-christophe@guillain.net)
	by mta11.priv.ovhmail-u1.ea.mail.ovh.net (Postfix) with ESMTPSA id 81B5B9A13A8;
	Fri, 13 Mar 2026 17:12:19 +0000 (UTC)
Authentication-Results:garm.ovh; auth=pass (GARM-97G002a3a49725-80a7-446e-b7c9-4b020084ec8f,
                    E50281848AA3A500EAF2CA0FEADB084EFD0FEAE0) smtp.auth=jean-christophe@guillain.net
X-OVh-ClientIp:78.240.83.207
Message-ID: <f49e0f4fc028966240c191ef59bf5c4e935c06a9.camel@guillain.net>
Subject: Re: [PATCH v2] btrfs: zlib: handle page aligned compressed size
 correctly
From: Jean-Christophe Guillain <jean-christophe@guillain.net>
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org
Cc: stable@vger.kernel.org, David Sterba <dsterba@suse.com>
Date: Fri, 13 Mar 2026 18:12:18 +0100
In-Reply-To: <ab5c12312b275589abd42c47a0c34b7e68375407.1773389056.git.wqu@suse.com>
References: 
	<ab5c12312b275589abd42c47a0c34b7e68375407.1773389056.git.wqu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
x-ovh-tracer-id: 5004625086269115163
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: dmFkZTGrwVLVG0zrFrVwavWGXqEXkpmNbZVtBW5sheGeDHqR6feMA25pEWiYjzizTTXaQe06b+7YXr/AxFg1TSvne1g2W5WaNVLcAXIq207VtwMFdLQEEr2gbuktLYw5VauxRHQ7FLG7El53fyrtjkep4eW22tjUjbyjwKA0JztosTBG8+e/OXDdjljb1OQqLMUI7BFApTuEtcv4Ywx2gHaOnJrbLSDyuo4/RlmRTiedeDDrXgHlxnJx/RqlhVbRJuHJIcJe3OhZgXh7ew76ZzQpH9ShvBm8qSPabfcv8FO0+tJDvzbHoOCaUFMGMB/T2t1u+AJOz02jzeheQtgahOKKYkZDPR0SaUIj2Jf0gQZu4nWl7SmaXehrXDtjbm+jRpHi2SIV1e8xA5yshpy9M6trGO0ZStL8xjsEyhnlzBGW+d9lWOVO4x9NezH6yJek2MQWq5SMWufIxYIj4MQWzkF/S44l7KTL3UQJ3UQS/drbqEak9jmbB1F6Fr4en3Gd8SfhIf+twUV1cz1C14FOIKPrPnleYxkfN0CTi//a33TeF85SHymCpDmqGredZLErXSRed283tH9uurBPqWgf5naiT7ev/FePVQgjYwzDmol1MH5ohaM+5dQ/mLiUvGOE6vCU8lf/aw8clZ6+mFKZsOqbqPWLp/bJveAkaV10u2LHAF8kNw
DKIM-Signature: a=rsa-sha256; bh=o9C8GlaQINVvOBi8fo+i1hg6qc0ZSM+TwzJ3qKNbgeA=;
 c=relaxed/relaxed; d=guillain.net; h=From; s=ovhmo31693-selector1;
 t=1773421940; v=1;
 b=VcJ55QOynT/YNcI+lR2/eCPNdjIcFWwR78Uo/XGFexmZ5IQWR+pWkre/qYlBwtpkd07syZKm
 KaiA83j34K0Q8b6FQRU4sVGZzyxN+NdTEWDb1eROcYAg95kvx9cq2mcrNEWy8bsw+8T4bH0Y64e
 1XacdFVuTEBe821N6X+1uoEhYyzinmuiHV5qZkoRrrqRr1Ejf6rYcEtHw83EPpjXWjdL6TO0hiQ
 1wGfckRTe9xjm8CTqNqpbh8HKm9CEoPFgALUmdnpEP7QGRrJnKpS7UQwGykJS/RkYmncrznB8QQ
 AP7Z5U6dNI01arnGvop0pQvcEh89h90/scumS6UBj9KXg==
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[guillain.net:s=ovhmo31693-selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[guillain.net:+];
	TAGGED_FROM(0.00)[bounces-225369-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[guillain.net];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jean-christophe@guillain.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 350EF288247
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-03-13 at 18:35 +1030, Qu Wenruo wrote:
> [FIX]
> Instead of offset_inside_folio(), directly use the difference between
> strm.total_out and bi_size.
> So that if the last folio is completely full, we can still properly
> queue the full folio other than queueing zero byte.
>=20
> Fixes: 3d74a7556fba ("btrfs: zlib: introduce zlib_compress_bio()
> helper")
> Cc: stable@vger.kernel.org=C2=A0# 7.0+
> Reported-by: David Sterba <dsterba@suse.com>
> Reported-by: Jean-Christophe Guillain <jean-christophe@guillain.net>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D221176
> Signed-off-by: Qu Wenruo <wqu@suse.com>
> ---
> Changelog:
> v2:
> - Add missing reported-by/link/cc tags

This patch (applied on 7.0.0-rc3) fixed the bug for me.
(The uptime of my workstation is more than 5 hours now ; it didn't work
more than 40 minutes before.)

Thank you very much,
Jean-Christophe

