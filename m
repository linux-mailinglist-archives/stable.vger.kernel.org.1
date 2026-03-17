Return-Path: <stable+bounces-225723-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gCuxJRmcuGkzggEAu9opvQ
	(envelope-from <stable+bounces-225723-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 01:11:05 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 254352A22C9
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 01:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B2D22306ECBD
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 00:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D77945C0B;
	Tue, 17 Mar 2026 00:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lg1wpstQ"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAC4433AD
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 00:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773706174; cv=pass; b=CznSGlKyLf1vsj71FhbsyEQ6fWeuYs1i3qQvhL+PyF0kXX0GzwUJcHtH+/TC4U39SLSJSKRYpCgDRNN/t/eARyelvsy2XWGxelKwCnUnNcvW0+g9N+swivx2UO8be3r9rMxW+jpspMRFq971wvEYm9AsM/9QclI4Kigm+sFyS5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773706174; c=relaxed/simple;
	bh=hHH0zbsAVNkdVzk96SM2ZhuoyeFWcJYCO04DOXgNmMo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tny2/4+YK3zq062BrTyRIsjbT39toWhqUDKseFIFAwwsdpmy6T8MOJnsDAoYTshTCZHUxOiWBW0W8hA4jgq0qI4SoHJeoIOPrCyyK0Cvs+fF0n8cz1IfAnU/Hp26LHITPHgf3k07NnQVv/vF4qsopISgw1O5wGi8THXTmb9ckZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lg1wpstQ; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b979d16dd0cso362406366b.1
        for <stable@vger.kernel.org>; Mon, 16 Mar 2026 17:09:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773706171; cv=none;
        d=google.com; s=arc-20240605;
        b=Z+ECDWWgO7NiaP8JnBVKOEoiUxRcIBdrjJYrtQa1g8zVLs/TlhcvVdc95qeUMfeUSV
         p2GQiaMbxKHdVEI2GicFvzAkiGp7GA83qOo9Jo1G/u5LJJjmg2GmN6YXBt2fzzP2KH6Z
         i9yRu7R8vNOOwUdDKchgyjNKdQ/d9/Fc78b63ukfA330P4z5kC0E3F8Yra6B8XBt7eAE
         2NO9Z8FEItXVMRNX/D173I0GkQ3XthHD+Kw8oBXKivHuqdR7Aclv/Zc+CKi/mH4X/BtV
         m4IY9WpVz3OrNfBGZSkD9/6RctqCIzUIq8kGwh96CK2bnVB8hJz8vz9lrxuvB6a9tCRl
         a8SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hHH0zbsAVNkdVzk96SM2ZhuoyeFWcJYCO04DOXgNmMo=;
        fh=wZSpTWgIP7NcmnT1dcOTsoD0LBzfynXwWuBnmNAkNOk=;
        b=LXrKCcbD8k1crHAk+lCPdzWucKvUhvDRcZWap61jYd2PNoYye4D0SRntV+OzExRacj
         sqjrcGCIfNl4vqu/MobEjBckhCYg5r1WVhxPCJccrRavRqMakY/fSRRuNeu69fEknIwJ
         /mnwoHGZzfkKm2AFD3RkwiMXSDwzdfaGSQzSqU/vIWqNP5BQ6oixpBjPZZ0ZvJcBiIe8
         xAPyG84MjvuY192QwAYdMM/Jhs7GEbzV+hUVPRyv7yU1gpNG1jbAv1flriI5JracJBtA
         rg/knG2p9YT3Z3cAW7gE/0t6YMTTlN6SJ9H0jyN6yiyQ1bh8v/EtID2/S+ST8ukyVkGc
         uCfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773706171; x=1774310971; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHH0zbsAVNkdVzk96SM2ZhuoyeFWcJYCO04DOXgNmMo=;
        b=lg1wpstQw5qLe0+ZJxVtqY1awPE/bYFmqRoPnSQoq1IDdO415Q51LvdA/UBlImgg4U
         kaN4RCn3wz6g01DLUj4ABOPTAWGTpCS/YlsweG7BtweKV2h6N4CH87olHDmTj6SZYjaA
         fUqI9fdde1tMVCFv+RzUyCXD8h2HDhZ7PqcjeIkH9FBjcQyRsFuhjotxTMPzK0VtEV++
         eK6fb4VaWy34NyphWTYsWifHXBQZ2B5CFyi66S7W4V11skIAMU9UDdgIlMdyujIpVut5
         fbiqWJitlA2/z1wF2LaF23fioc9KK4WTinmB4nnQ77kGyFk+L+jyJfaeWTGry2jEFJNR
         o2aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773706171; x=1774310971;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hHH0zbsAVNkdVzk96SM2ZhuoyeFWcJYCO04DOXgNmMo=;
        b=H9F8APomQSoTGf5oKmacBtLPyjyH/ce+24Jtxw5w+ezLltaS+1yPISwoqtBJfCLxge
         dcJ4DCZNaHKQqpo9Uh81SzdkABTga4seGRsS3Ra2+/Uy5QCFTOWqWEraExx2D38q6h8+
         rc9ICVT69Dw/v1C1nIgZO0PmZA421SwO67UXpOjNJOekU74ynZzlMQG6VtGMBmzX2IUp
         oWvD6YEtS5ZxBiRZE50RmODrNCg+0slI0VTqmvOzrsE7pVw2WYLuXz7y9Su/6D5268q4
         U9SZPjSNkQWeQpYraSOinVw1Yq9R7rjsx7JcgdDZz66IOQWyswpj0Gdu7h0bTnICMOjE
         GvZw==
X-Forwarded-Encrypted: i=1; AJvYcCXHULu6PoOm+H7cwnzgf0lv37059Ov5jOqKd/g/bZgq0qPYttFRokJ/IZi/2AoJN07921cxmmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZd4vJuoUonFrVcL0NddXUHvF011IKc5AXiJ2RjbhdvkhxQ10y
	3+I+9dPUWmb03QAreysPVgJtg8Vc5MFAjbMxEicHwd4ToPUJxwTceqqj+fIcP2tAAuVzan2SGGs
	qpJW/xx+6blCok5UWC4806uqgpXBYGGnbEltqu3dcf+9+
X-Gm-Gg: ATEYQzzReDn0ti3VZBvg4y/FSbcXdT3bVsYXa8/LNuJ+O0/DUo+w579pn8JWv/VUnbZ
	EDfx9mYY4YIl1BpuMb0QmNTc8cv0n36NcieLXvZp922E2Nix2dmzoHiAjQ6WvpWN4oNYW9qz4Dw
	+XDOLZo3PU2RHQApaB+MGDW4AO6u6NvgYRQl09Dmy4agTAaaZd7qgpRfwYBfBelmgdj6K47nswB
	+A6QVvWKuo+DvrwS/GfUvailj5+WCgyb+SiPDE6G9gTYimcgPLYIUfOh8ON8btpkCiP9lLnICtU
	wFw5jM/MxSEXgjp3cs5GZJ1dBwXpKyA/ylZHsbTv1N3Mg31te7x0AdWiuyv1xVTwHiw82MQpbRv
	w82Rwp9tlzOY=
X-Received: by 2002:a17:907:3f9a:b0:b97:dcdd:615 with SMTP id
 a640c23a62f3a-b97dcdd101bmr46515066b.13.1773706170825; Mon, 16 Mar 2026
 17:09:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316134640.2605237-1-gality369@gmail.com> <f3497ad9-8ee6-4185-b935-013e596e764d@suse.com>
In-Reply-To: <f3497ad9-8ee6-4185-b935-013e596e764d@suse.com>
From: ZhengYuan Huang <gality369@gmail.com>
Date: Tue, 17 Mar 2026 08:09:19 +0800
X-Gm-Features: AaiRm50tF6oYZiQBR8o55N2avJfUEiXBS-geZWxPXng4elSLAAsBYaYsERiaW1c
Message-ID: <CAOmEq9VVwimgxYxhUaRUv+7es4xd6u7-ttYGCeHC-+_Z1V6jhg@mail.gmail.com>
Subject: Re: [PATCH] btrfs: balance: fix null-ptr-deref in btrfs_may_alloc_data_chunk
To: Qu Wenruo <wqu@suse.com>
Cc: dsterba@suse.com, clm@fb.com, bo.li.liu@oracle.com, 
	linux-btrfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, r33s3n6@gmail.com, zzzccc427@gmail.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-225723-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[suse.com,fb.com,oracle.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gality369@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: 254352A22C9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 4:46=E2=80=AFAM Qu Wenruo <wqu@suse.com> wrote:
> I'd say adding a proper chunk/bg mapping check is the root fix.
>
> Or you'll need to adhoc a lot of null pointer checks.

Thank you for the reminder. A patch addressing the root cause of this
issue has already been submitted, but I am unsure if the solution is
fully appropriate and would appreciate further guidance. The relevant
patch series can be found here:
https://lore.kernel.org/all/20260314123741.1439792-1-gality369@gmail.com/.
Please take a look at the series.

Since you are not directly responsible for this, I didn't CC you on
the email to avoid causing any disruption. Apologies for any
inconvenience this may have caused.

Looking forward to your feedback,
ZhengYuan Huang

