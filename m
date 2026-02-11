Return-Path: <stable+bounces-215844-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YBq2H/uNjGn5qwAAu9opvQ
	(envelope-from <stable+bounces-215844-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 15:11:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 275E0125158
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 15:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 11C7030054F4
	for <lists+stable@lfdr.de>; Wed, 11 Feb 2026 14:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54F72BDC28;
	Wed, 11 Feb 2026 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LccLdpZY"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A23C126C03
	for <stable@vger.kernel.org>; Wed, 11 Feb 2026 14:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770819064; cv=pass; b=KMXzaeSGrBTyxMp0aiLFtUVNX9LeBcBz3HYB4YpCoDC0147YsWri4ERKJTdh4cykGXh2DWsic5plTpfYErOcG/FaGCD3bMwd0XKNOaDt9Ym6Wc/rnZQR4bmM2F2zcPuVfEFftIAtpq/9cAcc+2UMpHV0QxISg2haBWPV4s7trno=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770819064; c=relaxed/simple;
	bh=HGalqsLDx05eHACnNuEvrSN2qaYfOA2CfqzUgPN10Q0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8laF8Mt0uHJtOXYQnzwe5Vh58SOdmOoRbey+i288tZL5pWH4p47c5VTaYff7m2HPsxHRYWBVfHEOzL62E/vvhnN99n4Xk9hEba5vOjXA9poUKVggAsBCvQfXbPn/uMSgrbQHqikIp0/Nl2KwIir+0+1rp2+SUolFqcdvu/kRTc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LccLdpZY; arc=pass smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-12713e56abdso650729c88.1
        for <stable@vger.kernel.org>; Wed, 11 Feb 2026 06:11:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770819062; cv=none;
        d=google.com; s=arc-20240605;
        b=hruRFd/hajkBnQhdb5u5Vsr7QIphLBPcRW8H1eqJ7r11Zo45dQRvcUnKha+j8P9f3G
         PabBvvfzYW2CoJBjC37EOBvJ3HaMSC0BKSDGr0hiMKshgWNWluy8ns7Xm3m5Vi3tm9+W
         qZkoCUjxcZx7/vP5S9QfKvVnHEO+GxoI/ofT5bA7RSPOwgFhi3FatPUtt8o8UEk98PDB
         6qooZyFAvQOMNGe4gZZ+azyE4+q7jYsYSMhHw5lIuAqcanGiJlxeZAYYD4pNLmu5Okqw
         Gtfhjz1W6IhwpjE0LP34CaxqvTEZT8oRtA0UIWC3g9o4wxvlV/mlUPT5kRUXTUHsUN1/
         yoSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OKIseXHRmyCS6dHGzDMjOY6Hc3lPPbRWiScTys09X+g=;
        fh=GYvYqJGu13+aHxXR/Emr/Y4dS7ql2SN4jrGd4O0bnzI=;
        b=YmUJstjgiE33mCzeSVpsD4yxKLVbzCq6GHHkZjH+iHyL3H9wEUgDt874/vCqz0MTV9
         6T/c7UBPCI2yW+qqkvVSHEmhiJbbOcn0I2Bn/V29WzoJuWKJpfSPS8oVl2hUQpX3noVW
         31IrmI3yyCTczyAuqupee7F0NZ1dGGNX3jvYHkCzlvpVRfaHvoo2L/AdvQNbV/4BChaX
         ND/J2DHuPve3QYhOtPbvdfUU8LI4VGg0HD7TOORLL7dqmLFHJhuhovwGlg2ySHUvWXzM
         qo7lip373hdmsZV76yZkbyqUypvFcwjwytFvBqhb7eDK3YrqhmGo3yxsOuz4XRjo2M7D
         8yZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770819062; x=1771423862; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKIseXHRmyCS6dHGzDMjOY6Hc3lPPbRWiScTys09X+g=;
        b=LccLdpZYYOkWUJzWbk+TxwcRKtRAWM4GSaZoFr2Go6EMDhOBrfCurEg7Qu+qwtqxZI
         IZByxe10LUC/770DAcrSm/hv6sxgL8eNxQPblJb3brRAtetlsbh+ZvMy+murpkLrztqQ
         zoJ9HxgduNCsphe1w3ZaCRT/QLTNgalM01lKE5nQaycc3LXB2uweRtu9HDo3/yCK/4J7
         r35bQlVebwiLOTldlMnVzRP6WaYS6xDwxjPl3S4Sy0e6IvQ9CjaagfKnhRl1xLwgOQOy
         F3oqdawF/hbFdccMC2c346MYy5FjK9iLqvWl9Jg8KcZN1L0ciZitcbkcc/6MqqG78Xy2
         9Gaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770819062; x=1771423862;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OKIseXHRmyCS6dHGzDMjOY6Hc3lPPbRWiScTys09X+g=;
        b=Oxab3j6sXGm7wY8MOuB6j/RJxDUYcZ4dRjckVfuz67aaFkI3PfesZr4obLNEYXYfgh
         e194o0bvo/Ht1Kc7BRsjQCIqhO15yxOMplyhuWYnBctXz5ylaJQtXue2d+Xyf0CaHFQC
         uNYR92GYvJHwqIzn1igBVmfckMk6OAnFuBOlQalBBQ7jN0NUoYCKgE7LY1/p5/xP7lrS
         vUVzZHgrIljwSp26wEM9iBDUFQtJT9Wg1rEwrXECGwPfdFznjB3zRsfcJs1FIsGAtpQG
         pyecDfcag2+comlu8ipYxjOkrp0nfHyb4n19QQ5JWZZyoKj41Zu4UxRvU1Q20UGK8H36
         hhmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQm7RgTKmeKOySCAZT5182Q7n6ONt87hAmyZCsb3caJr6vM6z8vuXqN1/d+P+Sf2cXKZvGMTA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPtE/GLC/RJZgm6Fp8NcK6c2GjgpKTu9a4iXT5yWa3h/iJXl6r
	E9bK/wCz83nnLtqFDwtdVMN103TWVKam/4qNengE6qVftSwQd1kjfVv193MTMq1hCWQxLqXKDdn
	KgARDllwNNkuCcnzauijvlF0YTGxD+JE=
X-Gm-Gg: AZuq6aJx3Gw0YPorCxV8IVgnvu1698Jl0HO29/JmXc5pFcEZOhtwKGD2uObsS1r2a1Z
	8B58PSi7/+/T0Cgh+/m6FvsJJazhVyXYWOTnVAPQs2ePH/El5d73IBHwKAp3UynsXWNDPNe3BS+
	GAF7k3bDM6nGhe4qAWPiDgFMQC8M4R4RWIUPek3VY8QHtFd+1C70ryrQfs4GfL2sy5zFv0TGkbk
	rAdclxulR4Hq2Nnl0wNh4BK7T/76ep/gdDIkMeOBr4ZBymD1jW7ibfleIrFdEpVMY4FoWAZjVOd
	pAH5w1h8B8j2IOu13w==
X-Received: by 2002:a05:7022:211:b0:11b:a8e3:847b with SMTP id
 a92af1059eb24-127240d1eedmr2212706c88.5.1770819062264; Wed, 11 Feb 2026
 06:11:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260126022715.404984-1-CFSworks@gmail.com> <20260126022715.404984-2-CFSworks@gmail.com>
In-Reply-To: <20260126022715.404984-2-CFSworks@gmail.com>
From: Ilya Dryomov <idryomov@gmail.com>
Date: Wed, 11 Feb 2026 15:10:50 +0100
X-Gm-Features: AZwV_QhAs7em2PWlsOnMf3pcdJp5wd8MKB4Albp0QFwLsdVduX4z8P0balC06BI
Message-ID: <CAOi1vP_2asCJyLOZH0GP=u8gRLU6jqnS-hC-R7ayjPOkk0zc0g@mail.gmail.com>
Subject: Re: [PATCH 1/2] ceph: free page array when ceph_submit_write() fails
To: Sam Edwards <cfsworks@gmail.com>
Cc: Xiubo Li <xiubli@redhat.com>, Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>, 
	Christian Brauner <brauner@kernel.org>, Milind Changire <mchangir@redhat.com>, 
	Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-215844-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[idryomov@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 275E0125158
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 3:27=E2=80=AFAM Sam Edwards <cfsworks@gmail.com> wr=
ote:
>
> If `locked_pages` is zero, the page array must not be allocated:
> ceph_process_folio_batch() uses `locked_pages` to decide when to
> allocate `pages`, and redundant allocations trigger
> ceph_allocate_page_array()'s BUG_ON(), resulting in a worker oops (and
> writeback stall) or even a kernel panic. Consequently, the main loop in
> ceph_writepages_start() assumes that the lifetime of `pages` is confined
> to a single iteration.
>
> The ceph_submit_write() function claims ownership of the page array on
> success (it is later freed when the write concludes). But failures only
> redirty/unlock the pages and fail to free the array, making the failure
> case in ceph_submit_write() fatal.
>
> Free the page array (and reset locked_pages) in ceph_submit_write()'s
> error-handling 'if' block so that the caller's invariant (that the array
> does not remain in ceph_wbc) is maintained unconditionally, making
> failures in ceph_submit_write() recoverable as originally intended.
>
> Fixes: 1551ec61dc55 ("ceph: introduce ceph_submit_write() method")
> Cc: stable@vger.kernel.org
> Signed-off-by: Sam Edwards <CFSworks@gmail.com>
> ---
>  fs/ceph/addr.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 63b75d214210..c3e0b5b429ea 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -1470,6 +1470,14 @@ int ceph_submit_write(struct address_space *mappin=
g,
>                         unlock_page(page);
>                 }
>
> +               if (ceph_wbc->from_pool) {
> +                       mempool_free(ceph_wbc->pages, ceph_wb_pagevec_poo=
l);
> +                       ceph_wbc->from_pool =3D false;
> +               } else
> +                       kfree(ceph_wbc->pages);
> +               ceph_wbc->pages =3D NULL;
> +               ceph_wbc->locked_pages =3D 0;

Hi Sam,

While I don't see anything wrong with the patch per se, I can't help
but question the existence of this entire branch along with the meaning
of the error.

ceph_writepages_start() is the only caller of ceph_submit_write() and
it already calls ceph_inc_osd_stopping_blocker() at the top where the
error can be handled naturally -- nothing needs to be unlocked or freed
at that point.  Since mdsc->stopping_blockers is just a counter, all
calls made by ceph_submit_write() invocations in a loop would be
"contained" within that ceph_writepages_start() call.  The only benefit
achieved is potentially faster response to the MDS client moving to
CEPH_MDSC_STOPPING_FLUSHING state, but it's rather dubious because
sneaking in/having to wait for some more OSD requests isn't really the
end of the world.

Rather than patching the error path, I wonder if instead of calling
ceph_inc_osd_stopping_blocker() the counter could just be incremented
unconditionally, with the check for CEPH_MDSC_STOPPING_FLUSHING bypassed
there?  This could be wrapped into a new helper that could also assert
that the counter is already elevated before the increment.

Thanks,

                Ilya

