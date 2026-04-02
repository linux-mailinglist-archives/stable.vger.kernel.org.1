Return-Path: <stable+bounces-232927-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CUIM+8fzmnElAYAu9opvQ
	(envelope-from <stable+bounces-232927-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 09:51:11 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE1938570D
	for <lists+stable@lfdr.de>; Thu, 02 Apr 2026 09:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A8B57303B5F9
	for <lists+stable@lfdr.de>; Thu,  2 Apr 2026 07:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD87338945A;
	Thu,  2 Apr 2026 07:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f5OOnei2";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="emzyjofX"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C553822A9
	for <stable@vger.kernel.org>; Thu,  2 Apr 2026 07:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775116232; cv=pass; b=gogwl01yxswycOjlQB4kpYfKJPdj2sIXQRl3mR5ePQ4xq4uBJ8lDzmWXVMP/ipLzW2/cBg2ai/uL6JADl2o/oXXO2tULV6GmZZqwGfwfYZ0WfKv6swtGis2agwCJBnU+fhG8wkTbFnU0SMB0oufMlJt6QbL/23+sw7ISxPtdE9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775116232; c=relaxed/simple;
	bh=uktUuzl1PzMgmxaCTzaoE3jKTWjufVd1l+xKRsPkEb4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o0vqrfKgdbbW4F1OKQZOpXK83q/R/x6Kn7riZDTVP7OhVrhNLVmLGx3MkROh/tSNZ6nyQqAjG+nvL3JZsmP9GeBkblY0jV+3iMEnIcUb8NxzXVySsRlbuqN+bTkZWH5dERb3mrRncIZdQhe9gcPopyuL59oLTelPtjYVncelb7I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f5OOnei2; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=emzyjofX; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1775116230;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uktUuzl1PzMgmxaCTzaoE3jKTWjufVd1l+xKRsPkEb4=;
	b=f5OOnei2wtjnpzCDhCLHlgfVL4oCRdxtGaDAdgkGNwxN1bpfnMnlvSezB6OkbZyavGqrCh
	y57POcKYDBWMmr91h8SJIRdW7xWzYNKXHAZoiZHcUn9gH2PpPsTua1QdJH3WAWg7pvjQUB
	rvvNNA6W+37MI0Y4LIJCNZJm5M6xN5U=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-64-b_GEPK3dOt6t7EYeYayMzw-1; Thu, 02 Apr 2026 03:50:29 -0400
X-MC-Unique: b_GEPK3dOt6t7EYeYayMzw-1
X-Mimecast-MFC-AGG-ID: b_GEPK3dOt6t7EYeYayMzw_1775116228
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d0c06c232so563150f8f.1
        for <stable@vger.kernel.org>; Thu, 02 Apr 2026 00:50:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775116227; cv=none;
        d=google.com; s=arc-20240605;
        b=FOi+6NuEeAcEU6/+d6aTXPmukZyqvAKSGEIhZdpclepBUDsFvwgi3KEZ8S5bvP0tJF
         xqXUEzqB6Azd7l7adgMhy76ed+lcKdDOEP/YMeITyzWr8MnxffI4y0wiBMtbtgAURhYK
         /oZSNcepWrkqIB/a3CTFxyxfKxd1mdF2B0j3AidllYkW77Dq/Aw1HYZ8lUvWXl1RenwM
         Wj6hsEwnyNaIjf1CVUKNymxsk/kPWt54r0ID/5vg0uwSYd0ER5FxNRFYCxgdeLKksE9Q
         h2cTf9sXnng+pJYLeCAe/m7DVZhDUqSlZv+PKcErw9hNzXjg5cHmUheQFlhLdOPvvgiK
         Gixg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uktUuzl1PzMgmxaCTzaoE3jKTWjufVd1l+xKRsPkEb4=;
        fh=qqa2TSMh5ichaWwB/Rur9Bpxsj3IERRVJHigZ41o9Eo=;
        b=VBfNKe2X3/qJXpY5f3zZInnlQoZMGloty6XXuBZV5qpyaCByzHWp8ZovbSq4oWXP0b
         a6elpReL54wUIPKZ5mqjHLDo3G+Y/NHoMLO3fvwaGfOU9DH3DHgzG/R8cxRPev+QVHZF
         XUh7IVqkFwTFICmC80QmrbXh/mYo/AfkkLIR9hAmsLQ5e++FoHWfOALA+5WxCKjXOBPs
         wBxvwRU0TJx/VxNUbQNmG5hnlRyMCn7Rd/yUzDO33CEQNxH5QF+IdGpRIE4l36bopJnV
         J3y8b6vCkykON0xJ88eij0loVyz0RphUafr9XqixAu4aMEeYzfVtAAtxsNDyfo/Xr6UT
         lzAg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1775116227; x=1775721027; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uktUuzl1PzMgmxaCTzaoE3jKTWjufVd1l+xKRsPkEb4=;
        b=emzyjofXilzMg1u5dVyR7UKzywnhHYvZHAG2ujeLwD8/jL61tybr78gS0hOGWnhuCQ
         UgHzfQOBbmmGBdNAyOg40Jc963bqYwdageHFoCRTHtyM4aHRwYXch6CtCF08faHkgHnh
         ZMiAVmvEeqsC8ye1RrM0TFPsN7j18aPPZiDmWhbZWHVp4oj01yZd03UjoY+G+AaP+Z3r
         Z+0xq10GSkBIxEzvM3MZ0HGWxXeM5C/xjPgs+YOxJBxA3UPlzqshD8+1HJ80Tn2N4zu7
         mgXiYm08cNC+Bjs7gAagG8OOmn0TcC8i72j3aH10d0CRrqF1lXyfITkbnP83Sdfz+Tnn
         YrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775116227; x=1775721027;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uktUuzl1PzMgmxaCTzaoE3jKTWjufVd1l+xKRsPkEb4=;
        b=Rltjmtf3R5St4fJDpUxD1MTnRmVPgdt2arZqwcCi3+A2bv/m8SKMv9eBlwG3A73WbF
         Wsr6lwna6BT1/FD7QFXSquIw/OO4K87mJQCCf+YghRfyA/waTkXqPNUyPGoxDGWvJwav
         tMjrEWCuZTa/gYBB8PaOW09g2RGfioOol47tNOoFav6trmv6S+CcGxsvd+cWxIFlQlYr
         c9PUj0FDNDSZUilXj9qaFDd/d09YJpmUpNuJOQQ6iThFtpSFAPiEbvHIn5YhfVBmaws+
         PSLP9NS21eGXiYdgvkfrnsD/bhLUB9nCSTAnR9eF7zG4ADzIxlQhh8h/7IHqnHYz27d/
         rdIg==
X-Forwarded-Encrypted: i=1; AJvYcCUy96+rtFBcN9PXITar+g6Knzb9iNl/s/3WBG0zKzehRiynC/vTxSvS/VrOCwWjHtNzcJULJmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjKdV6NQ+ziofMHU6sFdfmCeAPQ6Ldp6tWfTJXC8g7Vr5qYL0R
	cU2XQmZlKJtF7xRZAu/OjjJwTvEdeUNL8oXH8vXIRs1LCDxkDTrViyfgMVd8Naa88qHesAhfv+9
	K5A9iR/gbTYqwCihjMZLf05IzLVwmBWi4FaZ1RGXgciBVsiF6fvTy8fEgPCi7/1dcs9wDFleW2s
	lHmlT9CmbCro6pdic/ZH2gWR7UHdQMXEvhrvJ0OiBP
X-Gm-Gg: ATEYQzzfcYRuSGjXMuZbvgkp/1mJp8khn8rz8M/rUy2xdOaXQzctA8ZpzLTIaNduH6k
	23Rm6g5TDtiZ7aGxXlmX8R1h+TgYhUycvc2IcCIrTn3xNAJD5xeO0dSN3ZYdXcysB909ugVEVOf
	v2xouvp26szlxRosNtsbp+Mt8CXGGzl11vYTDIbCt7hFlFtsm5D78eE73Xj8CTa6wkVV6/5qe4L
	hQse7/vrPziTPfZ2dj7VjcS/diHcHTryjYow/TWKPgSZSosdy0pTdBZpfkHgm/a5cIfq2BMmxqp
	BMOY
X-Received: by 2002:a05:6000:184f:b0:43c:f793:f1b0 with SMTP id ffacd0b85a97d-43d150f704fmr12485817f8f.40.1775116226973;
        Thu, 02 Apr 2026 00:50:26 -0700 (PDT)
X-Received: by 2002:a05:6000:184f:b0:43c:f793:f1b0 with SMTP id
 ffacd0b85a97d-43d150f704fmr12485782f8f.40.1775116226538; Thu, 02 Apr 2026
 00:50:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAB29vr=U=SaQR9m_O_cZwEKAG2LTnbYGjE+uT0snUT7Jco_3bQ@mail.gmail.com>
 <ac1OXbMbAY4snEPg@google.com> <CAO9r8zODkS5sViRaED9DS5UhuP2+wvUzCmF2L7MJuG0RUyEuRQ@mail.gmail.com>
In-Reply-To: <CAO9r8zODkS5sViRaED9DS5UhuP2+wvUzCmF2L7MJuG0RUyEuRQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 2 Apr 2026 09:50:13 +0200
X-Gm-Features: AQROBzDbo_UB8L7t9EPUKPw2yAJ2OO_yY6p1Y0aGStcwdRXgVDozYg2-lZSXuhE
Message-ID: <CABgObfazpG=V6rxn-=6Y2rv24zeMhK0L_AuAtXaHGXuMj5BnGA@mail.gmail.com>
Subject: Re: [PATCH] KVM: nSVM: Snapshot vmcb12 save.rip to prevent TOCTOU race
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, =?UTF-8?B?7ZmN6ri464+Z?= <jeon1691951@gmail.com>, 
	kvm@vger.kernel.org, gregkh@linuxfoundation.org, yosryahmed@google.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,vger.kernel.org,linuxfoundation.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_FROM(0.00)[bounces-232927-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pbonzini@redhat.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8CE1938570D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 11:49=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
> That being said, I personally do not object to LTS-specific patches
> (e.g. like the one attached), if Sean and Paolo think it's worth it. I
> don't really have time to do that, but I can help with reviews
> (although I will be OOO for the next 2 weeks). As Paolo said, be
> careful that some older LTS trees do not even have the cached save
> area, so they are broken in a much bigger way.

After the merge window, I will reevaluate submitting this patch to
stable. But that's all we need to do.

Paolo


