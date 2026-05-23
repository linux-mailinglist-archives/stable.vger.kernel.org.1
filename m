Return-Path: <stable+bounces-253923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CWBCk2JEWoJnQYAu9opvQ
	(envelope-from <stable+bounces-253923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 13:02:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E465BE9E7
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 13:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72870301585E
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 11:02:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D849384CFC;
	Sat, 23 May 2026 11:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qd5vraBT"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C319388E72
	for <stable@vger.kernel.org>; Sat, 23 May 2026 11:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779534154; cv=pass; b=ekcHgV3SHBAf8gyRgdbdTZfYL2vvcwXaosLUFs++t+xAB5tnIWepVZRQoy+Am9jG7CQYJpn5/DRoYrpHRk7o+FBCZyoj+rUohPrRbzCIeqisgOjuXsBGKNLU/AcDr/bRHzLYOFhPAYS6v5N41xEJ+9zgSzgwhINNjm0oHml3Lo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779534154; c=relaxed/simple;
	bh=8YPxUmKcGvWdFn6pUq77QYTQlpxGaKQQf85A5rfowlE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cMCkLm91i24IkTwt5JLjE9OhQefe0d+3pnz+bDOX+dmpIGSO74tzlc1eRau98SW8ekm/GOvpDFUzdcc8qwBo7D+s3NXBo2ija4NQtZHzSclJVWEB9zsy3otBmFw79TptPBZihANLoyqhc44BNFz8wsfDiOlfX8ZzYb0zD2iEAs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qd5vraBT; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7cff695e6b1so50622567b3.0
        for <stable@vger.kernel.org>; Sat, 23 May 2026 04:02:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779534151; cv=none;
        d=google.com; s=arc-20240605;
        b=lZqvzUF6my5jMiEDAZQFZ9q6F/+HHZDt9unHswWpLhyWhewjQfgSO+N/QgnZFAnf4x
         KLjeulGpsenrjFyYVCikVlNmwfE5eBGtdJkmdB2kKTxBW0F2PUHqrM5/DgAlmpHKWGqL
         U3vDQHWKfcuwg5wFPMQQoyz+FVC4Oae7ZML8/1ICSQZsYbggQA0tLhjrPMz57tbLymWR
         vXi7bTMsJJGT0qqfUGSpfKiUIu7OMoqSy4ITxSbJi9guy4JnBnXZ/dTyz4lnBYmn4Xhz
         UEwGzWCCHi35JT9NIINPkPK97RhAs0JP/k6F1IIrfC79H6oAYXK1SvEXEwOgKbovabcf
         bIOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f8fCyOFR8iTJDC8kmWton2tfti9/JeA5m8/3Cf++Fg8=;
        fh=gDN9JDwxB3ADymOLxAyYlk49RNsiZFbdKe2Lgd6lSSI=;
        b=WmKTeUaDB3DT11vjerNoKan/d6h61KccOz3NuRRq5zrZjNemmyCpTfJAkHk8UtngT3
         keOJffOKq/wimyuVe+OwG9PXoGAq87URL3VhehWqRYgJgQ59iqNPEVVbYur+sOg0b+qb
         J3ZH9CTTG/F6Vkxy3ZT/iGB1lmcl9xhVJC/B3Ftf1JJ9xBgZSWEay6xkANeL1entF8xM
         +H4ge+AJg6fBhddUHl85rTFIyWfm9YXDApWbZjhGus0ds4j+brmbzmAjIaf5QdxScO0U
         GWJvj0mKBPQMYkaOA4bFUIsdskeoIXRj/g1KFSA3bUf/I3iIE44+iE9UXh/mgHqQ2nO+
         29GA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779534151; x=1780138951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f8fCyOFR8iTJDC8kmWton2tfti9/JeA5m8/3Cf++Fg8=;
        b=Qd5vraBTcYKwJR11/7ikL1KwjhNnyeT8sJrD1TJQX82wYGRlvoAOsn4MQ4kChRRkTD
         JgP6J5HXwTNEABXNWDmJU0BgO9f3WprF6YV181FTyI3mVfdDDIkG7oHinbJTB2FpMD07
         D8XArQOEJvI8z7q1Z1PxeOaVG57LyyWiO5FYPjpeUSTW5xZzztpB6157ecNCSdLSDzIJ
         u3ihj3IkfLSjfF/+m0qAsRfmQU7VbUbf0TUY0EQnIqAG4G9+1pllevMlLjGldvrnpu5L
         YTGa8hqrMpV8Oi+OPhuFqy1e0eIMHJTzCfIntvzRrTS4N54WnvhjjgaTfZ5nLa3LyO74
         GUGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779534151; x=1780138951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=f8fCyOFR8iTJDC8kmWton2tfti9/JeA5m8/3Cf++Fg8=;
        b=I1PbU/UYzq6eMdjWUGbFKmJtiYF6EaC+j2AEe/Uy4DGRF1Riyey3Xkyqof8qh0dhKB
         qL2aAdI0H5OZ18Xm0EPQ2vhThV27Y9nUv/TGtZX2pEJYTRvmMOkUF4gF1J9+2aHbI3/R
         4BokLIjrNFkvgWbMaUb7O5A6s5ccYfE/lep9E0TjgjBh3UWVLQf03cXj2FlVbZTatEcK
         pgjIAKRt/Ox+dXLuejSfn3hnkeVRmsSevX42p7s3tm1iAlJr1vuB8/dUTI0fhIsxHGGy
         pIb2omGNLdax+h3fHnUYX4CNKBShFF5SERQTPm3Ix82PIYQ/z4WYwd7w33O+7Y6VKExN
         395Q==
X-Forwarded-Encrypted: i=1; AFNElJ//4fkE0MhfyRoydsXVaOAp9tWZN/MxNDAZz+aP8OCI8ItBi1rMN9B+Lgtt7o7NELKX5hheyn8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDVlRkJo5IOLHgOckLZQgGQpO8d01WeyidXiZCtpvfTes3svFU
	+XX7w2Qn/3BkbYIEM50AIxOo1BBcmytxY7GIpI+KHl9yTaIfglUOtuYQpoKI/kuVmkRcOSHI54H
	Jkwov5BwdYc708BpkMo9FiNj2Rz4wXys=
X-Gm-Gg: Acq92OH4VzrS/CE3jiFNn0dnHyk8e72mdClV9dkAnEp5bJvTdd2srsRZMa7WI7ymCzB
	N8bvXCppizhG6eTWQcxBQy5kEHNdlwu5yzpCwRxU+PBurIdyY92T6e5lDg7lD9WKAe9x46WUxVG
	35vZL2UrFuiCtk64v0bsifpynGHHvdq8HllDFkeKfwLyORb7NrYE3ewkmGpR+p4u/jGZlK1leLR
	U9g6EOjr3J9w+SfRAui/zXJ96vSUeQNZDhs+qOQI8GquQpqWXWQjbTHz1aq4P3rWmVz5XicaUBg
	0AlofyaluIYummKAQOC/H3jO/2zf5c8dEiwB
X-Received: by 2002:a05:690e:14c9:b0:654:5d65:9ff4 with SMTP id
 956f58d0204a3-65f3f4de008mr1056527d50.10.1779534150927; Sat, 23 May 2026
 04:02:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523014107.2460863-1-michael.bommarito@gmail.com> <8793ba93d173b82bd210a223a91664ee245b66dd.camel@kernel.org>
In-Reply-To: <8793ba93d173b82bd210a223a91664ee245b66dd.camel@kernel.org>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 23 May 2026 07:02:18 -0400
X-Gm-Features: AVHnY4LeFrYllrUZQFqsSaeBrspXtOWws8zkD6dO9Tih4q6y7o_N9f4-wdZrl8Y
Message-ID: <CAJJ9bXxc1C2coYCkxWYSk-ojq=XatuA_rje3NCA-s3e=NHhbpQ@mail.gmail.com>
Subject: Re: [PATCH] NFSD: restart ssc_expire_umount walk after dropping nfsd_ssc_lock
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>, 
	Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>, 
	linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253923-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 90E465BE9E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 6:55=E2=80=AFAM Jeff Layton <jlayton@kernel.org> wr=
ote:
> Comment is a bit confusing, given that you replaced
> list_for_each_entry_safe() with list_for_each_entry().

Sorry, that's left over from an earlier patch attempt that introduced
a different issue.  How would this comment look?

Concurrent nfsd4_ssc_cancel_dul() can free an item while spinlock is
dropped for mntput() above, so restart the walk from the head so no
stale pointer is followed.

Thanks,
Mike

