Return-Path: <stable+bounces-60725-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA049398FB
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 06:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A76FB21BEB
	for <lists+stable@lfdr.de>; Tue, 23 Jul 2024 04:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032A313B5B4;
	Tue, 23 Jul 2024 04:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UZTflS2m"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BDF13C8F6
	for <stable@vger.kernel.org>; Tue, 23 Jul 2024 04:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721710287; cv=none; b=YFvTAcoZ4GmBFnL1nmAX0Hx5rJu684gDi/inqZE0bPTBU9KQrj2FYWlWZm4SL+vBPZcfU4Ovk8j0ztteFpvSWIr7lpwRoEPy+ky16Sh9aIuWZO/XcDYSm7eDdmbd+oB58ueyZYsvR3inoD6AlFYPsvd2XcibIuYwTiGdYo6TjMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721710287; c=relaxed/simple;
	bh=ldg+LbqnHJ9gwDMdSZ9tPLEGrNZoIczhjCXH+CAGglY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bL63MrYGZmsVwuchQIgaW5kEdluNzYxIDytQcxjuDRYBS0gp/uxKPqYnE+dua/QLIJ0vCRd/7+BD8N45CjEJ/CSDVhRjmSDAPDn1WYzK+dS+kpCd5d9soQg2Kj3coHJWH5HQFnQam3xgkgfgzBuXjKAlYTxZlIlpdhYTxUvGFUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UZTflS2m; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3684bea9728so2882776f8f.3
        for <stable@vger.kernel.org>; Mon, 22 Jul 2024 21:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721710284; x=1722315084; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ldg+LbqnHJ9gwDMdSZ9tPLEGrNZoIczhjCXH+CAGglY=;
        b=UZTflS2mB9FkQbAvRV38twSK3cmMvQTYr/TrM/1vEYATWDhbjDQch8o3IrDVAzwHZc
         J30yutLb0J+8MInQ8C2/rI/dwiWMAuTYvg0qxu6IkcaIUIJdKe7uYUEoBVsYsVc5x2/t
         G9ruMr3zxPLn5Z/N6CYHNwGhoxeFigj5tFRtjAorwIhp+KIaNqBhLfN/t/8Rv1xfxsqU
         6hyvRIlP5CNrJlu89UDmIZsbOWf+p7uJmav5HmSMmQfCEbl6awJF8EicrpL9Es1Hwhgy
         6GNdLjYjwLJCtMQd94fq//jAhkxBERRooKkNtqUiACpgXzUh/nka1UbpTPaWeeYR+bwp
         1Wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721710284; x=1722315084;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ldg+LbqnHJ9gwDMdSZ9tPLEGrNZoIczhjCXH+CAGglY=;
        b=RUXuTx795mxbhB3qX6iaXjqZSh/FF/kGcat8t5t4+8DCcRdl+z4f1ti41zqjr/JXTK
         ImJ6jNJ1nxuU8ktTIdBItKpals3zhPre1V0K+EDTm2XK7/XFOcQCO6QbLnTmSDt4Qt8I
         7EjmQCAkR0Kvs+i8FNBl6+HMagokyLwzwpDjj6nWhE2+EM3lxII4Or4UZj1reH++Ijn8
         cJYnTKADTj3uimP0IthDF8UsRUtk2vY5PrVue+ghtZX2z076v+i5qDubeJoJEy9vyrdj
         4GB2ublYAg7XdtOU8PnqReki6TeLxux9eM9uktXwoOSCOWjXPPGuVcM5XCth7GVx8BPv
         PJbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmQ78fkJg1iXH3Y1844OJRgMMHMjnAzl1tMMI0uHLn+OwwtuVJDrxVJb54Us5cOD61NmCic++Qow+yryvgX3DtiIrwycG+
X-Gm-Message-State: AOJu0Yzb/WfMN3MTeIQamGrvIMsNedhgtiC/c1xSfLxTEg20vZf/4Gjt
	vRIUAdk38AM7oECeGTnGVowM1zvCf478oQqpfAdk5n0oLKFqXmu2zebJg6SJ1BxUSv9p/tJABaF
	O1Ib3bZTrTZugcBFe8JOz070/1j2CFeka+/hk
X-Google-Smtp-Source: AGHT+IG2djanOPTkwqVUsbPFqeMu/LXMrh5LaVa2ONuno1phEQZhKl74d/UNoiFTlwT/EaSCIcRczcStMaWrTCnhUEc=
X-Received: by 2002:a5d:4576:0:b0:362:2111:4816 with SMTP id
 ffacd0b85a97d-369dee56da3mr1046156f8f.55.1721710284258; Mon, 22 Jul 2024
 21:51:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240722035110.3456740-1-hsiangkao@linux.alibaba.com>
In-Reply-To: <20240722035110.3456740-1-hsiangkao@linux.alibaba.com>
From: Sandeep Dhavale <dhavale@google.com>
Date: Mon, 22 Jul 2024 21:51:13 -0700
Message-ID: <CAB=BE-Qqrtew6KKEjLfiEtcc0SDtP8PMhtby27OtF2eD-dD_iA@mail.gmail.com>
Subject: Re: [PATCH] erofs: fix race in z_erofs_get_gbuf()
To: Gao Xiang <hsiangkao@linux.alibaba.com>
Cc: linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>, 
	stable@vger.kernel.org, Chunhai Guo <guochunhai@vivo.com>
Content-Type: text/plain; charset="UTF-8"

LGTM.

Reviewed-by: Sandeep Dhavale <dhavale@google.com>

Thanks,
Sandeep.

