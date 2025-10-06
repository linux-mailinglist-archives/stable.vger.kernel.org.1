Return-Path: <stable+bounces-183436-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 13F2ABBE4CE
	for <lists+stable@lfdr.de>; Mon, 06 Oct 2025 16:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EB8F64ED1F0
	for <lists+stable@lfdr.de>; Mon,  6 Oct 2025 14:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD37C2D47F5;
	Mon,  6 Oct 2025 14:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEg8PCHB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA92C27CB02
	for <stable@vger.kernel.org>; Mon,  6 Oct 2025 14:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759760115; cv=none; b=KOjgdXXOoRANoDv3bT5hgWKMqz/truIGldAXb5qJ+Fz7Ezt2M62UdHbOSupdvsQf9EAV6e2N15k7jgfdZRLcI7HGMMya2JuP5qdBxvmno9Wjm4TI7fJIZ1oMQkPZUd2dtoysOK5GLUfecuazo/2DTW4NFaCjb3sqs2FK5pXoIIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759760115; c=relaxed/simple;
	bh=dpC1E3ty+TFIwvkaEmernFgK/zs4Oj/TxnNsvw9c65s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mg3MA6u+I3XHsodG3ltbtBhjMOwfImMiwHplVHImL2W1n1Wrtwp4o+lsWx2f9aASAS/QLhb4sMSnVRESTM30Euy6PYmTuDn6asd6mywL+W/WUGqjhb1PPW1mdlvSwexG+tUaZhhA4pfIPBBbrozvuq6wInPlqzQSw/ToGpKbn8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEg8PCHB; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-46e326e4e99so31225335e9.1
        for <stable@vger.kernel.org>; Mon, 06 Oct 2025 07:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759760112; x=1760364912; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dpC1E3ty+TFIwvkaEmernFgK/zs4Oj/TxnNsvw9c65s=;
        b=nEg8PCHBODwG66V2/NNuOnludfp1ZI9z8yOO7jDQ/5Y/bGs1N592mzlR4tiw7Yd7Sw
         rPJMHVMcplSmPtg59XVVVwGMTYm2t1QXsvCBVFON+bCeFfZwig+nANAG+2j/OBu2De2k
         +gFzTpQtg2ed6W612rxNxlq0SJTt+lLzWJEiuAzYRDwCz9bscGTwpXOdJUNdzxDT78Uf
         Bs2VqXKPbaId+VvgR2wnRkqvznMqaM2InfWFOCRxQNnSV7CRPu527ivZdFSxHDDcJaY1
         XNd/52MNEaw+v8rEM+5uOlJWxoVNL9vkpMsd8+3rWAM19QLQWg3tm/WPt9Oz7dhXeuCG
         CFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759760112; x=1760364912;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dpC1E3ty+TFIwvkaEmernFgK/zs4Oj/TxnNsvw9c65s=;
        b=Q06WcMhjJZLdFD1lDfjmLfS3iv/MWQRmU6Xrnq3kY9AI7A568kMSNgXOycsztlJ/yl
         H+YlgmWyvgzbgw2IJnOyH2n0L7tcSy7TwLiwXUdzRorbDuUtREoXqjVGEM8AK5Shnwso
         ACiSLfzSmYKm06ZED6DagHIxm+xBUB0CvxGc7fiVL0hAwJKAfS2KVoQi/a8JADdPYInx
         pN8FaFFJxLV6FkWOjKQiCHom0BBGYR/eiX6rNHf/5aLhOucqv24w/sDNWd2at1/ywdUN
         4Q7+/UPynv2cztM/mWtXyDe1hdjJBVUX5JDKj2KsFyTZbUmOHJn2nzPrGZjorcmHcSji
         Mo6A==
X-Gm-Message-State: AOJu0YwniFwH73lVR2z4i0kg0PLYUHasqP8ZfpbLx5QJ2Lh79Gfkgh/N
	sMcJjkBBgNwkO8BhVlVy7ANY2ZxMhyBxrpdbyjfmXWQEpSoZSRFU/UVd
X-Gm-Gg: ASbGncudq7y3BXCyAZ8d+MbBhTxllIQYeAbgefnyL1qCJMoWqE6sSoc/higHeUGvtDo
	MfA50AHsNXTA+L9Lf0iUMNIvuWOfyTxmgfsg+AKHpnX7vTAIzJqOPFewYZqJDyEiWjLs0sIgwXe
	XawI+ex4oFGX85adIPFmtlNclBhyOLmggENPUNmedU8z9BpK7OlHvX53ZwrMrdBCiIYnxX87ECv
	BePbiKbbgOH2ASXab/lSiAKVS8dPagV4A/vk1wSluqSePvIngxqBIpzDoywrIN1bkC4NHgdSOY1
	avjltJJYk7HR/s4MPDF5aJXXKy/axcKDbLeXuEmzx6MR2AVqbKR7qykun32Bode5e5j/b2C37mb
	JhAS++MBNPSFrmlERNzlHxGAQCPGJ79CXUVNTFz0W481KGlBj7pQsBUAlH4WfzfF5WkQIXMreeP
	Lu50SGEA==
X-Google-Smtp-Source: AGHT+IFvFV4OWJrtZLVyN6HOHxV1pZ8u+HpcMb9x2itMg3VtsVtai86lf60GZYy3ywG2hvyKpuqDFw==
X-Received: by 2002:a05:600c:530e:b0:45f:29eb:2148 with SMTP id 5b1f17b1804b1-46e70c5ca50mr85971895e9.7.1759760111974;
        Mon, 06 Oct 2025 07:15:11 -0700 (PDT)
Received: from [10.33.80.40] (mem-185.47.220.165.jmnet.cz. [185.47.220.165])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e72359e2bsm161672755e9.13.2025.10.06.07.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 07:15:11 -0700 (PDT)
Message-ID: <a4e912547211eed865bdf769647936c1e3034e4e.camel@gmail.com>
Subject: Re: Backport request for commit 5326ab737a47 ("virtio_console: fix
 order of fields cols and rows")
From: Filip Hejsek <filip.hejsek@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: stable@vger.kernel.org, Maximilian Immanuel Brandtner
 <maxbr@linux.ibm.com>,  Daniel Verkamp <dverkamp@chromium.org>, Amit Shah
 <amit@kernel.org>, Greg Kroah-Hartman	 <gregkh@linuxfoundation.org>,
 virtualization@lists.linux.dev
Date: Mon, 06 Oct 2025 16:15:10 +0200
In-Reply-To: <20251006062851-mutt-send-email-mst@kernel.org>
References: <f839e710b4ede119aa9ad1f2a8e8bcc7fcc00233.camel@gmail.com>
	 <20251006062851-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.0 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-10-06 at 06:29 -0400, Michael S. Tsirkin wrote:
> On Thu, Sep 18, 2025 at 01:13:24AM +0200, Filip Hejsek wrote:
> > Hi,
> >=20
> > I would like to request backporting 5326ab737a47 ("virtio_console: fix
> > order of fields cols and rows") to all LTS kernels.
> >=20
> > I'm working on QEMU patches that add virtio console size support.
> > Without the fix, rows and columns will be swapped.
> >=20
> > As far as I know, there are no device implementations that use the
> > wrong order and would by broken by the fix.
> >=20
> > Note: A previous version [1] of the patch contained "Cc: stable" and
> > "Fixes:" tags, but they seem to have been accidentally left out from
> > the final version.
> >=20
> > [1]: https://lore.kernel.org/all/20250320172654.624657-1-maxbr@linux.ib=
m.com/
> >=20
> > Thanks,
> > Filip Hejsek
>=20
> But I thought we are reverting it?

I'm kinda confused by this question, because I thought you already
understood the situation.

I sent this backport request after a discussion with Max in the revert
thread, from which I got the impression that the virtio spec
maintainers were unwilling to change the spec to match the Linux
implementation. That impression might have been wrong though.

When you sent Linus a pull request containing the revert, I realized
that there was no consensus about which side should be fixed (spec or
Linux) and told you that I think it should be reverted only if the spec
is also changed. You then sent a spec change patch [1] to the virtio
mailing list.

I'm not familiar with how decisions about the virtio spec are made, so
I don't know if that change is going to be accepted or not.

[1]: https://lore.kernel.org/virtio-comment/7b939d85ec0b532bae4c16bb927eddd=
cf663bb48.1758212319.git.mst@redhat.com/t/

Best regards,
Filip Hejsek

