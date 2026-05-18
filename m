Return-Path: <stable+bounces-249376-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oDxrIaZkC2rwGwUAu9opvQ
	(envelope-from <stable+bounces-249376-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:12:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F89572B56
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4BFBC304CAEB
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F41E393DDC;
	Mon, 18 May 2026 19:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGGUxyRF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37386390234;
	Mon, 18 May 2026 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131323; cv=none; b=p0h0YJq9VxqO4yFMQPkE8f8NiBXzZppB4kJFS3vLu4flycdpO0RsLi3xgTstn9YAmwL6FNfzVJuTb7AJRleY0FO5uzqsuQgocqtRzgljFY06/JjZd9L4ZlTfz3A4uYbGhfxj42l7MPDgyNaXOXXgs0Ob0NsNCW7lZiKAz9nM2CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131323; c=relaxed/simple;
	bh=qrNWUqU6HFJ7j9AuxwxcwGKKPBsZYNa1H1abIW9Mv7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFm8wgEwIh6TsLH917ldlj3fH8wRl7/i2b0hBEBS/FAAM7pTQplHHwbDpwKHfCDBMADLe7i7Vc95kq3jNED9lZyTl8dTl6WSpCg0ubzrC/lOS/kRLNMvd4Xz3+EuL1Bq1zqjzfqgH1URpvsS840eBRO1sukVJBzq/J1eWy0L1KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGGUxyRF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 768AFC2BCF5;
	Mon, 18 May 2026 19:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779131322;
	bh=qrNWUqU6HFJ7j9AuxwxcwGKKPBsZYNa1H1abIW9Mv7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iGGUxyRFZITiDnGSZWFimSmLNugKbfmEuf9Moj/IVbzJJwNFFMbcYQ3g4kzAH7kpZ
	 lw8xY3lgg9jaECowCM5ilvIPhiRfXZ9BCyNX8OT48RlTJaAfeyLNDTgZtxz4da0/7Q
	 ENSbED5scYNOJcygV81YCzMkiE5cQpmItND3uccLfdflNlNW01iOwo0QuxZWs2Z7nO
	 blGI8Gzbh4UWwYTY3BB7TeHvDeGMGCUSIAE1FLkD4UssIrxmDkGLJA4DnphvGW9NS4
	 Hn42sSQWSM/+8QmDVUNams8se54V64yWX7JD470UyVrt0Q0oPzcOS+t826KgH8EP15
	 YjbqfTRD2IaTg==
Date: Mon, 18 May 2026 12:08:37 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johan Hovold <johan@kernel.org>, linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>
Subject: Re: [PATCH] HID: core: Fix size_t specifier in hid_report_raw_event()
Message-ID: <20260518190837.GA2318678@ax162>
References: <20260517-hid-core-fix-size_t-specifier-v1-1-bfdd959ec383@kernel.org>
 <CAMuHMdVzWL0WZe6u-uY2U+uCNUKB1aNTYM3kaYkX=OJBCY9G0w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVzWL0WZe6u-uY2U+uCNUKB1aNTYM3kaYkX=OJBCY9G0w@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-249376-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nathan@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 29F89572B56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Geert,

On Mon, May 18, 2026 at 11:10:49AM +0200, Geert Uytterhoeven wrote:
> On Sun, 17 May 2026 at 06:51, Nathan Chancellor <nathan@kernel.org> wrote:
> > --- a/drivers/hid/hid-core.c
> > +++ b/drivers/hid/hid-core.c
> > @@ -2050,7 +2050,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
> >                 return 0;
> >
> >         if (unlikely(bsize < csize)) {
> > -               hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %ld)\n",
> > +               hid_warn_ratelimited(hid, "Event data for report %d is incorrect (%d vs %zu)\n",
> >                                      report->id, csize, bsize);
> 
> Both report->id and csize are unsigned, so should use %u.
> 
> >                 return -EINVAL;
> >         }
> > @@ -2072,7 +2072,7 @@ int hid_report_raw_event(struct hid_device *hid, enum hid_report_type type, u8 *
> >                 rsize = max_buffer_size;
> >
> >         if (bsize < rsize) {
> > -               hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %ld)\n",
> > +               hid_warn_ratelimited(hid, "Event data for report %d was too short (%d vs %zu)\n",
> >                                      report->id, rsize, bsize);
> 
> Same here.
> 
> >                 return -EINVAL;
> >         }
> 
> And more incorrect %d outside the context!

Yeah, I had noticed this as well but I decided to keep the patch
contained to only address the instances that the compiler warned about.
I do think this is worth addressing in a follow up patch, which either I
or the HID maintainers can do.

Thanks for the review!

Cheers,
Nathan

