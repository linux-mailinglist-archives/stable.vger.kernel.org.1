Return-Path: <stable+bounces-114933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DF4A30F96
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 16:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398F0188800D
	for <lists+stable@lfdr.de>; Tue, 11 Feb 2025 15:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94839257AC4;
	Tue, 11 Feb 2025 15:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zlXt9jOq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YPmhN0+g"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAEAA256C65;
	Tue, 11 Feb 2025 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739287289; cv=none; b=BPZjHqzG63bPtUzwPqXK/ZsHnudt4RoFHXX5H8HasrnmDpVM1VegdKDo+6IiaobdsDN/6zDNKM0kO03r1Fzi+ELoy5qiJjnN9NNHpCgeVBPSWHNuporgORsuthEIM8U1HTtJ9MVYLScojUX3ZtMIRlGBu3Ox5WF/m771/+3Zl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739287289; c=relaxed/simple;
	bh=b6PgNLkPScF9l7086At1232ATken8hsBuvwb5T7rW8Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gp6fw2Af00R1LtD7syf/xIEMGjDqsYvNPvUw0pTgNL64AdzqnXCHGSxVFxM0DrQOxPbFaaCJ7TU/cmQLLgkXY14huCfQQowKSOFBIz3NBem+4x0UYhfr6yM3yy29dnzkvxVXaQwhqrjGP+jh4dgb91PSyak2YyUCgS01hCWBNrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zlXt9jOq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YPmhN0+g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Feb 2025 16:21:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739287286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FR0dpvCelCBgD2VFUIgBkNkzP2YkExLCV7qs5XzhJeY=;
	b=zlXt9jOq+UwwVXoSyIisxF0og6D3Xq0Mzt4kgf+cTaR6ojZVPn+mk79XMvjfos9k9tD0hq
	dBJt5P4PKtcWSuqwwzLsIAuPVzmkU+QiN/p9wCR2A1PBRAzBAPqqS68k6mmvrVT7smvsbb
	MIUJoRF16TIW5diNaOmpDNCYQMFASVNryoPUWbsm4or+IYHuyzMzxUiYbF6MrDKsjV/rdz
	jrl8ympWk/u+ahwuRLZRv/+CDSEO3n48SXfYvKgdDxmXfEeXWKy1qdSxtDOyrh1Qa/TwUR
	JUL6HtUzAjZ8b1WOsEYS7o/N03BNcxLKmMkscwPPGMUgjdGxk5hvZUecUeOq1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739287286;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FR0dpvCelCBgD2VFUIgBkNkzP2YkExLCV7qs5XzhJeY=;
	b=YPmhN0+g7brpEcRNPA+/mBG5IIjNH6tTC0uH5d16+5wp6SHOHWKapZrPdgxoFH3fCRV7ou
	sRCuAchSMLv8WTBw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: Simon Trimmer <simont@opensource.cirrus.com>, 
	Charles Keepax <ckeepax@opensource.cirrus.com>, Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] firmware: cs_dsp: test_control_parse: null-terminate
 test strings
Message-ID: <20250211161448-c6560879-7bc9-4fe1-a9cf-713f029c1ee7@linutronix.de>
References: <20250211-cs_dsp-kunit-strings-v1-1-d9bc2035d154@linutronix.de>
 <d1c9a0f3-5bc5-4b78-abfa-d17e90c36f48@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1c9a0f3-5bc5-4b78-abfa-d17e90c36f48@opensource.cirrus.com>

On Tue, Feb 11, 2025 at 03:10:38PM +0000, Richard Fitzgerald wrote:
> On 11/02/2025 3:00 pm, Thomas Weiﬂschuh wrote:
> > The char pointers in 'struct cs_dsp_mock_coeff_def' are expected to
> > point to C strings. They need to be terminated by a null byte.
> > However the code does not allocate that trailing null byte and only
> > works if by chance the allocation is followed by such a null byte.
> > 
> > Refactor the repeated string allocation logic into a new helper which
> > makes sure the terminating null is always present.
> > It also makes the code more readable.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > Fixes: 83baecd92e7c ("firmware: cs_dsp: Add KUnit testing of control parsing")
> > Cc: stable@vger.kernel.org
> > ---
> >   .../cirrus/test/cs_dsp_test_control_parse.c        | 51 ++++++++--------------
> >   1 file changed, 19 insertions(+), 32 deletions(-)
> > 
> > diff --git a/drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c b/drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c
> > index cb90964740ea351113dac274f0366de7cedfd3d1..942ba1af5e7c1e47e8a2fbe548a7993b94f96515 100644
> > --- a/drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c
> > +++ b/drivers/firmware/cirrus/test/cs_dsp_test_control_parse.c
> > @@ -73,6 +73,18 @@ static const struct cs_dsp_mock_coeff_def mock_coeff_template = {
> >   	.length_bytes = 4,
> >   };
> > +static char *cs_dsp_ctl_alloc_test_string(struct kunit *test, char c, size_t len)
> > +{
> > +	char *str;
> > +
> > +	str = kunit_kmalloc(test, len + 1, GFP_KERNEL);
> > +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, str);
> > +	memset(str, c, len);
> > +	str[len] = '\0';
> > +
> > +	return str;
> > +}
> > +
> >   /* Algorithm info block without controls should load */
> >   static void cs_dsp_ctl_parse_no_coeffs(struct kunit *test)
> >   {
> > @@ -160,12 +172,8 @@ static void cs_dsp_ctl_parse_max_v1_name(struct kunit *test)
> >   	struct cs_dsp_mock_coeff_def def = mock_coeff_template;
> >   	struct cs_dsp_coeff_ctl *ctl;
> >   	struct firmware *wmfw;
> > -	char *name;
> > -	name = kunit_kzalloc(test, 256, GFP_KERNEL);
> 
> This allocates 256 bytes of zero-filled memory...
> 
> > -	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, name);
> > -	memset(name, 'A', 255);
> 
> ... and this fills the first 255 bytes, leaving the last byte still as
> zero. So the string is zero-terminated. I don't see a problem here.

This single instance it is indeed correct.
In all other five it's broken.

> Just fix the other allocs to be kzalloc with the correct length?

If you prefer that, sure I can change it.

Personally I like the helper much better. One does not have to look at a
dense block of code to see what the actual intention is.
Assuming the location in cs_dsp_ctl_parse_max_v1_name() was fixed when
some breakage was observed, with a helper it would have been fixed for
all locations and not crept into upstream code.


Thomas

