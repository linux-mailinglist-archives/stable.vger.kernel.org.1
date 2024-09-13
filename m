Return-Path: <stable+bounces-76054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4758B977CB8
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 11:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E66091F275DA
	for <lists+stable@lfdr.de>; Fri, 13 Sep 2024 09:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746D11D7E22;
	Fri, 13 Sep 2024 09:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WURHdlxD"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84981D7998;
	Fri, 13 Sep 2024 09:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726221563; cv=none; b=VnGTqJfL17jp1NqPnwVjrq8x7zVLtx25CRa+nqe66GldsJb7LJashN/hxB9dwZacEn0zMErC1JOye9T2C/tMa73PmJWcGgjAuSy/WbBTKn/vijwW6Bt8mdvD3qFWX4KyMeht0xPGlXS+HGkQaD1dWqsqcy3QmMVnR1sA8z13GlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726221563; c=relaxed/simple;
	bh=3+NbSZ3etjvKYRx4sm9SGu5IqWM9BNB/WQxIlcSu+zw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hEhIBlf0XX6aNSH44v6c+c6Usdig+N9eE4WwM3lXrH8la/eimEXGJH5rYXPpIM1KcimD0s5pihej9EAW8UdZdbyZB1w4XCFEzbo5u1/0veQOMsuDAxo1JkxBViK+6VUt4JW96gCKT8fwBM9/BP22w8hHlhhZjA/F2zj9MYsSC7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WURHdlxD; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a86e9db75b9so278216766b.1;
        Fri, 13 Sep 2024 02:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726221560; x=1726826360; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+NbSZ3etjvKYRx4sm9SGu5IqWM9BNB/WQxIlcSu+zw=;
        b=WURHdlxDuGT9FPUxsfQCi6T1HMeUOjWFo590lTg8HmrJf8cTQiKDO9WRk1TERLSbdG
         w888AInEQ02xK+Sokj6wNj0OyZrp8Gi5T3YwdCKrXlhVxwN74zyiufRHFf8xWgqAkmNN
         VjVrh/Y/LvV4HFUHcS7Z339fzwKj9lqzLizlzpWZjHqYcplkhLFPtxsIzeFflCmXp+8j
         j58DpyKxfDmsOLVkcB3eJ+4VRL6hQ4Xsp/QbZypSl5uQ3dAhd5SHkYNAAri2uRg0DcJo
         J8JStjoj9e4sINsZPRe/mh+jkuw8iq3H75eweCHzACZwRapzmgNDGiuK+9L9gxWo7VRo
         QQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726221560; x=1726826360;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+NbSZ3etjvKYRx4sm9SGu5IqWM9BNB/WQxIlcSu+zw=;
        b=Omopa52NMBN6qJOcdMb5bbEdNB7wHIvzXZXmXqy2YaT3EvVE/Di9QLVx9WN5lQDQi1
         Wi/OzD0lPruniA0sglFM5+/bMRiS5ZDY478bWVzaQwiKXz+eFOe4PS/3s7QtCS5FhOQc
         qNHdoaZATW/hXQEp7Ou3aEwOFy7/4EVcfBcSfOcJ2mvrWkdyQJ443NAQfkmCM6zkEKSr
         xs4VzSnyeCA3Un83uesNZuarP1me6iMD6Rglp9Z/6ja1cl11UPL/Fn4XjPiEIxF55iXs
         YJkfTsh9JY2ZV7JMglZex6HMbHhuAmfS+YtOE6NStutbtVwys5CF0Q/EIonrGlrf9G1J
         MnAg==
X-Forwarded-Encrypted: i=1; AJvYcCUGAJO4CBs8xREsAIIqXNFvqtOeQpKosPV6vKTem0J3uj/unpuXgghzZxq3ToC8Gs3W9DmeLmKfVgxj@vger.kernel.org, AJvYcCX8o9HWq6mZvK/OmcKpoJbx5HTELcrvUch8qF8rxD11ijs/kmKEFAzmJ8Yp21A1LwsEK/c4i7wd@vger.kernel.org, AJvYcCXB0t93S1ayeLQF0v1c92+cLnCfT3GXuv0pXrzBwyxKradL9RLUDUVZXAV3kv/w9IS4PRrsME+o5jC5jzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyblGxLcXWhHJ93H9PJjJBuKPo9YwvWau40CtSF5HB+ZCPrnMhQ
	x+sdBJtwgVPM1QBcScIRTa7GKnVg0aQkYb1PrxinKraWQQl851WsRZbeqmmE3HhyXqJd+nm3oMM
	IXdji+rqJb7i/SjG47zeqNliTTLA=
X-Google-Smtp-Source: AGHT+IHykOTcthTjBRQ45AGDlyV4+KjC8hweDGxJDxkIBpD6K6YsFn1B5hioCcBaxqBusZecaQhw69UeMtFb6ngBJFo=
X-Received: by 2002:a17:906:dc8a:b0:a8d:7b7d:8c47 with SMTP id
 a640c23a62f3a-a90297315b9mr609687866b.59.1726221559701; Fri, 13 Sep 2024
 02:59:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905065716.305332-1-pawell@cadence.com> <PH7PR07MB9538584F3C0AD11119403F11DD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <PH7PR07MB9538734A9BC4FA56E34998EEDD9D2@PH7PR07MB9538.namprd07.prod.outlook.com>
 <ZuMOfHp9j_6_3-WC@surfacebook.localdomain> <7e73a66f-e853-4da5-bb95-f28c75d993f2@linux.intel.com>
In-Reply-To: <7e73a66f-e853-4da5-bb95-f28c75d993f2@linux.intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 13 Sep 2024 12:58:42 +0300
Message-ID: <CAHp75Vca4PCa0DfDF53g8=GuFzSxmbQUR4N985R7AtLa=F2=Jg@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci: fix loss of data on Cadence xHC
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Pawel Laszczak <pawell@cadence.com>, "mathias.nyman@intel.com" <mathias.nyman@intel.com>, 
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, 
	"peter.chen@kernel.org" <peter.chen@kernel.org>, 
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 13, 2024 at 11:59=E2=80=AFAM Mathias Nyman
<mathias.nyman@linux.intel.com> wrote:
> On 12.9.2024 18.53, Andy Shevchenko wrote:
> > Thu, Sep 05, 2024 at 07:06:48AM +0000, Pawel Laszczak kirjoitti:

> Thanks, fixed and rebased.

LGTM, thanks!

--
With Best Regards,
Andy Shevchenko

