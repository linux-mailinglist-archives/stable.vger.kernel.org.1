Return-Path: <stable+bounces-46016-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3758CDCDD
	for <lists+stable@lfdr.de>; Fri, 24 May 2024 00:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99572810A9
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 22:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF0D128383;
	Thu, 23 May 2024 22:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fk5GCNxh"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8D8127E36
	for <stable@vger.kernel.org>; Thu, 23 May 2024 22:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716503248; cv=none; b=HWRw8ctA+LjRKyihBSnAKG6ItwyAC+lgiCNI0jK0c6oqlxAqJ/IPQCZkB9n1ABoXYXNf7oRw1Bg/xTfMnSDMIsnGGe45ENog3DomHaxqMXGzWQsGSJztaKoeW+N2eeZOTEQQQbXyPQyzAetUneGnuxoBy7nlBYLdstQwVxZH54c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716503248; c=relaxed/simple;
	bh=c0mUxdCgsi2KrVeRpxcSZB8MmwArsNnruIBgy6wP7iI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dnrQTp79Uc0zvIDwHSTMkYbGb31Nz1fO1Yy14woWZAgnASNOmUO+AH0pHFkrOhMqYr9xSWXVWM0UeogvVGaAUP/qLA/ZVAs+xnF/KN7nUNsRf7dvH0azufQn+CzXnsMQ/uwPZwWjzyfrsLIx57cf44zzN4fWJHZPjjK/7Nw7tMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Fk5GCNxh; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-41ff3a5af40so12585e9.1
        for <stable@vger.kernel.org>; Thu, 23 May 2024 15:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716503245; x=1717108045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c0mUxdCgsi2KrVeRpxcSZB8MmwArsNnruIBgy6wP7iI=;
        b=Fk5GCNxhPiar+UgjNqjnKxi3IrfdHjW+vWX1rl0MwDv2tlTs+VPfAHSQd1NVMLJ/oj
         WdBIQh9qnx7y55/v7xKhuDVIVtlQB8E7EoJtsOFq8HuCOAZ6n7NK4wOHkFH0FOxN109P
         sMmfcWa5GWHiOvEv/ub+4QWHvduAa2wQDvMzvrNyXgnNu0GUYRXqiZ+nQqp5I3//awaa
         Kr6byBq2exfk0RwXSaZEYeMouLmyq1HR8Bq5qMpzRkf7Hkfap1fxczP6PYxOpS89vMB9
         Fov9woabWfVVxo7QZrjljmf01fb6NERXovNLbGUXP7cLU+A6ImjpOekKQ0qaH5IJLmWe
         JpHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716503245; x=1717108045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c0mUxdCgsi2KrVeRpxcSZB8MmwArsNnruIBgy6wP7iI=;
        b=M/0nYXPhoW0DYsUhxgLomNJJAkNLdwLrPSOcFHZIeLNtsqwiKHaNQPumf2UCdCp1T5
         X3YYhlCe+kmRkZCjOvJgNBAYjQcfqp8GS8+PeVDX/xt6DCsxJrdKanIwkm4EItqZ+Vw0
         3lKpJWP/9A7pKBU6OZQRDT0R6HE/Oh85dOKtS1ufmyuH4jyy4R5g8YLon785jDkbLa7i
         gh8WuXq7zKtqOdpT8Ml5+daoMDMUMqYuGu6iXvOcWLGRkuzT6YwFtnSNJb6CXtYtT15h
         EVA2NSd1UBtiZaarKM9YSKOodsZIce964aac5weA9hZ2mrNMdWQkIPVFNusuowMK6M/P
         +jhA==
X-Forwarded-Encrypted: i=1; AJvYcCUMb1Th4fBJrb1BCcsu71K4rYpm8AVJ0e2h5csvJpDFbBVguBqnt82zbUvHzupS53Vuv90ixiIv0T7baEooIhaXmwU36kpY
X-Gm-Message-State: AOJu0YyaSagiG3QhKDFR8pUy/qbw1qHY+000ox4i0/WdpapL5NEt73ol
	yE7Jd0DZLfYsuJFUQr/NJa/Rb+oxhykwnPtXouFLTHTcSvTPqWzAJ+nrJ/QAZ2iuUyXNA1Zom8o
	StU5ebShdeFG7hoT1iGazcX4DNuv3svK/S2Yn
X-Google-Smtp-Source: AGHT+IFynCndXxQSRyQxEh3uszYlhUwS4moW4riJN/2gUPi0KmtIvL9iA7r73v9YHUvtIeizmNWwYHzCkJkFOKSr2sg=
X-Received: by 2002:a05:600c:3d8f:b0:41f:a15d:220a with SMTP id
 5b1f17b1804b1-42108625e09mr650055e9.4.1716503244634; Thu, 23 May 2024
 15:27:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAzPG9M+KNowPwkoYo+QftrN3u6zdN1cWq0XMvgS8UBEmWt+0g@mail.gmail.com>
 <20240510060826.44673-1-jtornosm@redhat.com>
In-Reply-To: <20240510060826.44673-1-jtornosm@redhat.com>
From: Jeffery Miller <jefferymiller@google.com>
Date: Thu, 23 May 2024 17:27:12 -0500
Message-ID: <CAAzPG9MMHoHjR=EAAM9Rgkaih9QjU08tF6d8JrjQ43td=-oAVA@mail.gmail.com>
Subject: Re: [PATCH v2] net: usb: ax88179_178a: avoid writing the mac address
 before first reading
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: davem@davemloft.net, edumazet@google.com, inventor500@vivaldi.net, 
	jarkko.palviainen@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	stable@vger.kernel.org, vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello Jose,
I can confirm that
https://lore.kernel.org/netdev/20240510090846.328201-1-jtornosm@redhat.com/
resolves the up/down link issue for me when applied to my 6.6 kernel.

Thank you for resolving the issue.

Regards,
Jeff

