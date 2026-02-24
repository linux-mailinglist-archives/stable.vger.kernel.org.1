Return-Path: <stable+bounces-217855-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOPJLw4enWm/MwQAu9opvQ
	(envelope-from <stable+bounces-217855-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 04:42:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0982618173F
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 04:42:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88725303A270
	for <lists+stable@lfdr.de>; Tue, 24 Feb 2026 03:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB3123B61B;
	Tue, 24 Feb 2026 03:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CnjH3vW2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="H7rFd++Q"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2171A9FAB
	for <stable@vger.kernel.org>; Tue, 24 Feb 2026 03:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771904522; cv=pass; b=qPP59P5lLKLPN9N/ETO21BJuTignNNy5Ru61NJM2WzE2pTuURTDY63V4h3TCQ/yQIciySLqMON7Po0OwHQtahD1a0IC+FyIe+DEd89aYNvFBh6nIOM/rvddXaGABEpHvUjqccBlrOZR6lCPbHs1xMeIdUWzeljzY2X5Nqm+MIXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771904522; c=relaxed/simple;
	bh=ZfGi+rTpkYSFnpVCfQmyET1TglGZ7PTVeu2IkOlJh3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnrgs1S+YIBpF8N972fKm6fybLCrAiNSsixoTOdIXnnGBGR34phuZrXWTyxzUntihyIZpH73CC9Oy8tQZPRTV4h9fFlacS4kIazhHuHsSZbHTndwwlsNZSk3pJ/VLqFSIJ1kpIXtSOwDSvoeNw6OfdS0oyyV9DtiMHIIQCzsjx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CnjH3vW2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=H7rFd++Q; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771904519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZfGi+rTpkYSFnpVCfQmyET1TglGZ7PTVeu2IkOlJh3U=;
	b=CnjH3vW22+jTwbUKp0wPUpnYX1btpmKXE6IZPgTA0E0RurOICeqMSMWEBo7PZwZ4HvMbu9
	NVPPD5GIrqUG6t978MTNWB7GM3424XmGxZxJTGkSzF9AzyDDYM+nKGYKuFwnwSZ5RqEgH8
	5ci39sWPLjQugVuinHy3CFX8v8/yviA=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-P7oyLHgDPB-wNIaeeqWNsw-1; Mon, 23 Feb 2026 22:41:58 -0500
X-MC-Unique: P7oyLHgDPB-wNIaeeqWNsw-1
X-Mimecast-MFC-AGG-ID: P7oyLHgDPB-wNIaeeqWNsw_1771904517
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2ba7e98178fso4554536eec.0
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 19:41:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771904517; cv=none;
        d=google.com; s=arc-20240605;
        b=K2M+hTGf/tRj1PJjyoXjkAcTvcSGwMuOsXRYgMKQcdbKBM2TwWXqRdJH1dEhU7QHNi
         XkLxW4p3MgXKUS97dXZlQ1lfCystnDB1sIg0roktkhBHRtp1jIEGZkMQoeNG4c1BCWBW
         ntfZ2ngVV5LouSeVwScVpppauMz6L2P89KnNagMcgTZuOjIqtD1c/22vmwYr4AE+tjlJ
         PfAw/g2FBX8ofo91o/aIXue/UVnAdvXMjk+mjKN1UJ/5liX+2ritSZzBqyWDMaFJ003E
         bBDyf5g9YgqkRrcA+9DOzjQaG1q/hKkJn01pF3Qh3+2rnOVrQZe0lpFafd+kuxya/XKE
         XdLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZfGi+rTpkYSFnpVCfQmyET1TglGZ7PTVeu2IkOlJh3U=;
        fh=4M1iNX5609NZPnWVzdf5s0/fmT5RQ0WccgPWariHeq0=;
        b=gA04otMZFedZJ8fvTemZ5hBM+edcF+lU2aM8b872pLV3oKRky7X38h8nUW/wFhy5vm
         WrlQv56iwaLHtpvw5wdjjEQn34cq72KUyIOsqoSh8fWb+bOLtRxH5V2ExFwvI04WUcf2
         BkrZNP0AsDDvyJE47B5Lo5qLd28Eq9dT85uHVroFd8GaZzm9nD2CftxpAeCQMuAVsC0l
         GCRQwrURE/d6RyckwX7oDoE2jJOShlLfALmw+FcFf4dBgA6cBimu0XyLePY9uJiMy/a8
         ucmWwrsOKeJtt3C9Jhw4XbH8cHwmCQNxNINy7P+J6sdMldx5ItjvLEd5SzA8iJRFGo+G
         b8cg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771904517; x=1772509317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZfGi+rTpkYSFnpVCfQmyET1TglGZ7PTVeu2IkOlJh3U=;
        b=H7rFd++Q1p5f5a+dNO4rllXx9439DXk7dzPxD/XHJ8hai9dGFM/fo3VAXmHQQbQ+Dd
         4M+IwI+UuA41157KVLbwePb8nhxROoimSPdxdFhwgh/d58TCUT/7OUr2vUdjNxFFn/mm
         LhUxmEW0cuHvZaI5rtjT9DnoJ5iq/3I73yAyE4lfV/xiSgE71JTHPEPEq3Asi8iAsfYc
         qCVXdqFG22lt762qJ1sr4L9tMYJ68mbpOVRg5X7jRFmOiZJbo+GNkMKDnPEW82aV+pKO
         xas7hr78ePLLSouHZlFNvBkX78KjPNqjmegA290fipQSLYpLjsHxpLD9Fs7htZl6eiBO
         naqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771904517; x=1772509317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZfGi+rTpkYSFnpVCfQmyET1TglGZ7PTVeu2IkOlJh3U=;
        b=Y75S1ZsgM7wGase4TgtIQ76GT00CAIa9+cJOgx5tQaSc0HJ3HayBLdxoB+qRk22fLq
         7LqLzykV+06495uveUb+Mmp3JsML7cLzcNif32bmJnaBgqIq48fN+dQvIHVmfc322fSW
         GDgCm89L2BzyQG7mFkY3QMWpmPcoHDl+7BIoo911f++8HJA8GaN4su4I+RAZejb5A+Dt
         n6obX29JSIvlZWthEbPPkGa8LQKlUz7+xSzHnZn4TsmOkxDYLwNcf+gKNEpJyiGAlrPk
         JLDYy4+aT8Od+wwnVKgYRGw0Xq8homZQHBgLMYg0KW0uYW08Kh0quOBf9X6I9cSx85Do
         mm1A==
X-Forwarded-Encrypted: i=1; AJvYcCXsYnX0Km/8YqSCEDM8n1LFPD5xri21AvkELarhvOtl4nSVdJWhdLgN40vLMj+Rh8/h7Shukso=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC+qyfDxg5t1pICe1EJmyaqhjgGBhI+9o3QYp4qHRKS0L/NUbG
	OSTkaPjC2mZIQF0GZu0vAOGyFPwV4NDsw7PeNKQltYfsGkJdUzOQR6x/SdeLHAp5ipDvAbEatbv
	WJ1GKkDj0R25CJ+eJX1OpxK7VKJzGzxsFDZjkC/C3qRGNN4YwzBFI9VDfEPHFZLDGdj5tWQohXO
	sIDWdxi9AJ3ZcUGkABwxF5cxofDJs2ZXDhOA6bpRzD
X-Gm-Gg: AZuq6aJVUNtnMq+0Tg0g/f2dNAVHlDVtx8a/j+rBqptcnkg4Uw/l4tG1wWWDLeIeu3e
	KrtIJvQS/qihtkUkUJHMQOQ3OWmiMVpvddF0WhXAxf9LoYeO9LpCJBtkHyV2dCX2C7xjYnW0+tC
	ZfYMxHERSfXO2yk5UxDoZ/078Im6u99MN/PyZG0lcP3USt5BvPJz7ak0l8lQaaNKQx7hcQGXZvS
	SUEwU42Nb34sGN0p1Vjw+1oPPnv7384lWPv
X-Received: by 2002:a05:7022:6986:b0:11b:923d:773f with SMTP id a92af1059eb24-1276acb7fe9mr4491845c88.5.1771904516618;
        Mon, 23 Feb 2026 19:41:56 -0800 (PST)
X-Received: by 2002:a05:7022:6986:b0:11b:923d:773f with SMTP id
 a92af1059eb24-1276acb7fe9mr4491833c88.5.1771904516247; Mon, 23 Feb 2026
 19:41:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DGJPMOESHINC.1NGNT8LLY8DKW@kernel.org> <1771594440.99434@nvidia.com>
 <2026022156-citizen-shredding-5d6d@gregkh> <cdc31857-c9a0-4d05-a243-780dc9819cb7@nvidia.com>
 <b45a50ce-de96-42ee-90c1-0a6cd7a78cc0@linux.intel.com> <DGMAUQLZGPZB.FWELZM9GYP0Z@kernel.org>
 <DGMP4FBY8958.1KNWJH7IW7M3I@kernel.org>
In-Reply-To: <DGMP4FBY8958.1KNWJH7IW7M3I@kernel.org>
From: David Airlie <airlied@redhat.com>
Date: Tue, 24 Feb 2026 13:41:45 +1000
X-Gm-Features: AaiRm50BDo_t3xPlwTJEEpGzOePwAdIFv9N6YtS43JfkuKqEUHkSqaC-olJg6xU
Message-ID: <CAMwc25q4hXq-ztUHRnMaiWV4aqZeNypU0c_9hatsU_Pyov1G2Q@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] gpu/buddy: fix module_init() usage
To: Danilo Krummrich <dakr@kernel.org>
Cc: Koen Koning <koen.koning@linux.intel.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Greg KH <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, 
	intel-xe@lists.freedesktop.org, Matthew Auld <matthew.auld@intel.com>, 
	Peter Senna Tschudin <peter.senna@linux.intel.com>, stable@vger.kernel.org, 
	dri-devel <dri-devel-bounces@lists.freedesktop.org>, 
	Arun Pravin <arunpravin.paneerselvam@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217855-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[airlied@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0982618173F
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 8:31=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> =
wrote:
>
> (Cc: Arun)
>
> On Mon Feb 23, 2026 at 12:20 PM CET, Danilo Krummrich wrote:
> > On Mon Feb 23, 2026 at 12:17 PM CET, Koen Koning wrote:
> >> Thanks that makes sense, then let's just stick to addressing the curre=
nt
> >> regression with gpu/buddy in the drm-tip tree.
> >
> > The patch should go into drm-misc-next.
> >
> >> Joel, could you grab the v1 of this patchset (or the v2 with with
> >> subsys_initcall, either works) and try to get it applied to drm-tip?
> >> Since this is my first time submitting patches, I'm not really sure ho=
w
> >> to proceed from here, and it will probably be faster if you have a loo=
k.
> >
> > I think we should land your original v1; I don't know if Joel can push =
to
> > drm-misc-next, if not please let me know, I can pick it up then.
>
> Actually, since GPU buddy has a separate maintainers entry, I will leave =
it to
> Matthew and Arun.
>
> (Cc'd you both on v1.)

Since I pushed the original damage, I've pushed this fix.

Dave.


