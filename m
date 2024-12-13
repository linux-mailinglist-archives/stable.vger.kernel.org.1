Return-Path: <stable+bounces-103995-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A3B9F095B
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 11:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D8561692FA
	for <lists+stable@lfdr.de>; Fri, 13 Dec 2024 10:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F661B85F6;
	Fri, 13 Dec 2024 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b="hQpJn3os"
X-Original-To: stable@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F09861B6D12
	for <stable@vger.kernel.org>; Fri, 13 Dec 2024 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734085512; cv=none; b=YHlgoVCe6IDOwDed2sPV9x0JlQipmm1ruAvJGQFwpMw6qCYmi8NP5bMi/C33fT6Iom/W/ojsB9R9TN/lA1Uj5V456ldL/c+yYRoajV4nPFVu7maT4YDvDI+IT0/xhj5EihKZFiBBwJpjgGsKdb2hQxpqtDaoLaFei/P3gQNNI3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734085512; c=relaxed/simple;
	bh=xxemndcgGBgHvy4pUq2pCRoPdfELtkEIGMFehs3zHFk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbfV5TC6idcbUatfiQBwGqPzYc3+R0dTN3PUbI2CgpjN52SapymLo8aO6cxrgHgf/ZDJCs3C01AnCDqPCPWgBYC+tIvyaTgoBWCvpK85fJw+auBOc45gfGWC66xmXBUc0BhyhfvPvenR1yW0MtEmLFDAXBTgtBxwhsEOs9c0ATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com; spf=pass smtp.mailfrom=mvista.com; dkim=pass (1024-bit key) header.d=mvista.com header.i=@mvista.com header.b=hQpJn3os; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mvista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mvista.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-29e91e58584so778231fac.2
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 02:25:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mvista.com; s=google; t=1734085510; x=1734690310; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xxemndcgGBgHvy4pUq2pCRoPdfELtkEIGMFehs3zHFk=;
        b=hQpJn3osqN0K1oOxjUy4TmM9KFFnde/LbmCcdBPSMPPUdtodaosp/KE7HH6qLDG1o3
         ritlzG+cA4KHfbVAHVrP1kpeHJpt6s/BQGA4sBcc/DC8KLEHubwtKhEka7ibTUvXIzaN
         v5lr1zUvRvYsYyvwCCpCEvBctC9mKlNVOwsxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734085510; x=1734690310;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xxemndcgGBgHvy4pUq2pCRoPdfELtkEIGMFehs3zHFk=;
        b=cZp51t8d/6dL8vbDzylQ7rrP9rk+JauIK1xLqihrRIrPVXg+W2RAPXswgwet/+gZwF
         XPnBn5CHwymp6gMXSvnwYy+gvZ1Zs9pQKC79K8QnxOYuesVULxSRAkMeRss8JOKkWBNr
         9wqCWGJOvJE7kJlzYfML2277CFdyaMDHVzPOsQ7h1777wjA51W7RGNDQpfJEtZy3bMNd
         MFxpyXl8RJuSNl2bDzZlDJNwJ1cyZwnMvUsfQpEVNrb5+GQTqhW95xP0oi/vN9zz7GrE
         DPoucyjLaeLF8gxQk9PFasMzfRpse/XD2cOpsqVUaS1cQ1cTv4rFvmTrR0ZzVmVZN32N
         SxFQ==
X-Gm-Message-State: AOJu0YwMPgS8W9lMHb+wvF1NZvRUTKFdRW9eXfGV2n2xA0cNw8F5HBRr
	JZ11Utw3IH3B5Z+tz0VXTxL31Tym3YPQt01mSxNS8PHeg2Ni3MYbH3+eV5j8AQdEhLGDB7K7hRU
	sTW0CRf0822/98KOBnpHGTWIcoV/OUvLqU2gPMA==
X-Gm-Gg: ASbGncv1VVvs2FGvpVTxc4NQb5XFejmgamVHVPbWJ1RtU6izAw+lTBc+h9EfMohfzkg
	SXAFMfQAhYHdp3HNTkkC3ScMXJ/ZYCgGKFP8l729p2u05bGHuI2vXE9Whs1GmdzoB5Oj7eg==
X-Google-Smtp-Source: AGHT+IEdT/A/pmiS2ym+9RC5WzDSjkjUMBatBt8gNsmX6iOQyltgrvwe461J4dlxyPDv7Ks2W1Btk2iEGxVCCFVfE2U=
X-Received: by 2002:a05:6870:7011:b0:29e:3d0b:834 with SMTP id
 586e51a60fabf-2a3ac614135mr1216192fac.5.1734085509982; Fri, 13 Dec 2024
 02:25:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1729316200-15234-1-git-send-email-hgohil@mvista.com>
 <2024102147-paralyses-roast-0cec@gregkh> <CAH+zgeGXXQOqg5aZnvCXfBhd4ONG25oGoukYJL5-uHYJAo11gQ@mail.gmail.com>
 <2024110634-reformed-frightful-990d@gregkh> <CAH+zgeGs7Tk+3sP=Bn4=11i5pH3xjZquy-x1ykTXMBE8HcOtew@mail.gmail.com>
 <2024121233-washing-sputter-11f4@gregkh>
In-Reply-To: <2024121233-washing-sputter-11f4@gregkh>
From: Hardik Gohil <hgohil@mvista.com>
Date: Fri, 13 Dec 2024 15:54:58 +0530
Message-ID: <CAH+zgeEhb2+SmB7ru8uGuNs+QX==QAWxeDgOHUQ_G3stWbMBWg@mail.gmail.com>
Subject: Re: [PATCH v5.10.y v5.4.y] wifi: mac80211: Avoid address calculations
 via out of bounds array indexing
To: Greg KH <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, netdev@vger.kernel.org, 
	Kenton Groombridge <concord@gentoo.org>, Kees Cook <kees@kernel.org>, 
	Johannes Berg <johannes.berg@intel.com>, Xiangyu Chen <xiangyu.chen@windriver.com>, 
	Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"

>
> What did you do to change this patch?
>
> Also, what about 5.15.y, you can't "skip" a stable tree :(
>
> thanks,
>
> greg k-h

I have not done any changes to patch but tested the patch from 6.6.y
by applying to 5.10.y and 5.4.y versions

ref:
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.6.65&id=26b177ecdd311f20de4c379f0630858a675dfc0c

