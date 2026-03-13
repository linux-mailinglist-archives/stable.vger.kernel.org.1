Return-Path: <stable+bounces-225309-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLeENKIVtGlkgwAAu9opvQ
	(envelope-from <stable+bounces-225309-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 14:48:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E09E28431F
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 14:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C485B30923E2
	for <lists+stable@lfdr.de>; Fri, 13 Mar 2026 13:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED5A3A1A48;
	Fri, 13 Mar 2026 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BA6P4hjD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DE563264F3;
	Fri, 13 Mar 2026 13:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773408527; cv=none; b=kNkZOB7RKKs7zs3o/52vUBAX77Q8mbT3n2Jy4J3VYOFenSup3oUymgdej1hiPoq2PzTmlDRF/Xh+ebRPi2tKY+q4pD8Mp5tJBbqn2fNyK44sQInOxWTvh9S7yv6dNSjthdUH3ou0bUF/X/i+HYGovIbAmjDcJfjDXYp9cy4T5Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773408527; c=relaxed/simple;
	bh=O0gqbP/30/ClS1ol+vdztMDTLfFPaTJvksNQ5DFWZU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZHRl0lC8Dod3hF3YY9sAeorPUW+L0WXJJUTJocPbkOwqlE7YaPOArV64/zmUdr+5BHGwVFEPpPi01MZzzBF6dF5XMdbwAJUc7N8/epc0xrRxqEm2/LbXjyPuLa8O15jKux/Nl5JT8UN3WXK7BHhUWMoYM8Qa11VAty1foFwjaHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BA6P4hjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3798C19421;
	Fri, 13 Mar 2026 13:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773408527;
	bh=O0gqbP/30/ClS1ol+vdztMDTLfFPaTJvksNQ5DFWZU0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BA6P4hjDl4gdLW5miQu5qj59YCPPJdBmWo77gbRvwnE41HXaWkm4g/idUUdMPUB7M
	 kBQNVIFLM+EBWKzF6QMqFRRsZVKXCA049wYICRQnJwwJseanlp+G5c3g8DePL69dNm
	 SMl4AEMNG5YeYxcPsau1UHusVbIdL5huOh/yIXvO14xee8KvYSqKYkbw3Bxdhf4oap
	 QrNhzbHffSjIRb08vqUVejz0ajdR7zln19mvgey39fi8UHIH73pJIaTmZiKVpmf4WE
	 Xs7NfkqRl9x7XTry8w2Auo/11f0+/Ij5J3SwY2D2A4GxLsywUdNIQkSm0EecLVIdfy
	 wN31ttfRkqsnA==
Date: Fri, 13 Mar 2026 14:28:06 +0100
From: Benjamin Tissoires <bentiss@kernel.org>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Jiri Kosina <jikos@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-input@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel test robot <lkp@intel.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/4] selftests/hid: fix compilation when bpf_wq and
 hid_device are not exported
Message-ID: <abQQQ0KNxJeO3JIZ@beelink>
References: <20260313-wip-bpf-fixes-v1-0-74b860315060@kernel.org>
 <20260313-wip-bpf-fixes-v1-1-74b860315060@kernel.org>
 <20260313095731-682bbab2-5861-4aea-bc83-420492400c19@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313095731-682bbab2-5861-4aea-bc83-420492400c19@linutronix.de>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-225309-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bentiss@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,linutronix.de:email]
X-Rspamd-Queue-Id: 7E09E28431F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mar 13 2026, Thomas Weißschuh wrote:
> On Fri, Mar 13, 2026 at 08:40:24AM +0100, Benjamin Tissoires wrote:
> > This can happen in situations when CONFIG_HID_SUPPORT is set to no, or
> > some complex situations where struct bpf_wq is not exported.
> > 
> > So do the usual dance of hiding them before including vmlinux.h, and
> > then redefining them and make use of CO-RE to have the correct offsets.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202603111558.KLCIxsZB-lkp@intel.com/
> > Cc: stable@vger.kernel.org
> 
> 'Fixes' missing? Also for patch 2 in the series.
> 
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> 
> Reviewed-by: Thomas Weiï¿½schuh <thomas.weissschuh@linutronix.de>

Thanks!

> 
> (Some nits below, feel free to ignore them)
> 
> > ---
> >  tools/testing/selftests/hid/progs/hid_bpf_helpers.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> > index 80ab60905865..2c6ec907dd05 100644
> > --- a/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> > +++ b/tools/testing/selftests/hid/progs/hid_bpf_helpers.h
> > @@ -8,9 +8,11 @@
> >  /* "undefine" structs and enums in vmlinux.h, because we "override" them below */
> >  #define hid_bpf_ctx hid_bpf_ctx___not_used
> >  #define hid_bpf_ops hid_bpf_ops___not_used
> > +#define hid_device hid_device___not_used
> >  #define hid_report_type hid_report_type___not_used
> >  #define hid_class_request hid_class_request___not_used
> >  #define hid_bpf_attach_flags hid_bpf_attach_flags___not_used
> > +#define bpf_wq bpf_wq___not_used
> 
> 'bpf' would sort before 'hid' alphabetically.

ack (note that the last 3 are not sorted, oops).

> 
> >  #define HID_INPUT_REPORT         HID_INPUT_REPORT___not_used
> >  #define HID_OUTPUT_REPORT        HID_OUTPUT_REPORT___not_used
> >  #define HID_FEATURE_REPORT       HID_FEATURE_REPORT___not_used
> > @@ -29,9 +31,11 @@
> >  
> >  #undef hid_bpf_ctx
> >  #undef hid_bpf_ops
> > +#undef hid_device
> >  #undef hid_report_type
> >  #undef hid_class_request
> >  #undef hid_bpf_attach_flags
> > +#undef bpf_wq
> >  #undef HID_INPUT_REPORT
> >  #undef HID_OUTPUT_REPORT
> >  #undef HID_FEATURE_REPORT
> > @@ -55,6 +59,14 @@ enum hid_report_type {
> >  	HID_REPORT_TYPES,
> >  };
> >  
> > +struct hid_device {
> > +	unsigned int id;
> > +} __attribute__((preserve_access_index));
> > +
> > +struct bpf_wq {
> > +	__u64 __opaque[2];
> > +};
> 
> The fields are never used, would a forward-declaration be sufficient?
> 
> struct bpf_wq;
> 
> Then you could also avoid the #define dance for that struct.

Unfortunately no. The fields are not used, but the struct is stored in
struct elem, and we use that struct size to compute the size of the map
elements. So we need to tell the compiler how much memory it needs to
be.

Cheers,
Benjamin

> 
> > +
> >  struct hid_bpf_ctx {
> >  	struct hid_device *hid;
> >  	__u32 allocated_size;
> > 
> > -- 
> > 2.52.0
> > 
> 

