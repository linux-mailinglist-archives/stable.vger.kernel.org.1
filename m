Return-Path: <stable+bounces-191463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EDB6C14AEF
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 13:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 664831A686E8
	for <lists+stable@lfdr.de>; Tue, 28 Oct 2025 12:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A152332E125;
	Tue, 28 Oct 2025 12:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EHakmdqO"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24AF32C92A
	for <stable@vger.kernel.org>; Tue, 28 Oct 2025 12:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761655651; cv=none; b=odXKT82fu5qaCQd3RTp78PW7Mfv3KnkbZmdsQysMkmI/v9kmDdTJwcAXLYUkWHDAVtwneqnjoq36TTNER0PAjPgk1dOJBX+aqrKA0K/S3TW3E2LHrbEPpLGHoLXh6sUEXeCo1QaCsXFlxnMaoRDo8LqtrE+50t5TATyKuEhxwx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761655651; c=relaxed/simple;
	bh=3zxxLe5jRo+vXweHkY8a9rjPQMveFzyUyTGtDUfeo3s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uvK6NBJLR/E4CmynJ7MtlD8VFNDB2h9QsiC2mXxnWeAPYjO5IrX1xMQa6tpevL5HySnBc219IFCWWY90xS6AhXT2RVdvOsx1gpPG74L4mAih/GZnOGiwzf815iLjGJ1RPxrKQIcVOrYoohTdAOlDdeAQiGA4+ibLUEo9kDIYUMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EHakmdqO; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761655647;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=beqtIomf4y8x1aMjch5sbfoJy9RZVg0qDYuZDDoU1ro=;
	b=EHakmdqOFe90k1tpg4JpDe9ldsuae0Oqo/jMyppIkBF5Q1Cp9kOKWGJ95dzrEMgI6pr23V
	loegjx1uhX18TDhdF+xIcWPNmxg/CbFEGQmI6/v9iIQ/SG3WNv1EnMzxaQ2HLn13YYuNH0
	1DeawuzlzlKLbctTKKI26MfG5mkMkT4=
From: Yi Cong <cong.yi@linux.dev>
To: linux@armlinux.org.uk
Cc: Frank.Sae@motor-comm.com,
	andrew@lunn.ch,
	davem@davemloft.net,
	hkallweit1@gmail.com,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	stable@vger.kernel.org,
	yicong@kylinos.cn
Subject: Re: [PATCH] net: phy: motorcomm: Fix the issue in the code regarding the incorrect use of time units
Date: Tue, 28 Oct 2025 20:46:35 +0800
Message-Id: <20251028124635.362957-1-cong.yi@linux.dev>
In-Reply-To: <aQC01GDPr-WclcZS@shell.armlinux.org.uk>
References: <aQC01GDPr-WclcZS@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On Tue, 28 Oct 2025 12:19:32 +0000, "Russell King (Oracle)" <linux@armlinux.org.uk> wrote:
>
> On Tue, Oct 28, 2025 at 01:07:34PM +0100, Andrew Lunn wrote:
> > > > >  #define YT8521_CCR_RXC_DLY_EN			BIT(8)
> > > > > -#define YT8521_CCR_RXC_DLY_1_900_NS		1900
> > > > > +#define YT8521_CCR_RXC_DLY_1_900_PS		1900
> > > >
> > > > This could be down to interpretation.
> > > >
> > > > #define YT8521_CCR_RXC_DLY_1.900_NS		1900
> > > >
> > > > would be technically correct, but not valid for cpp(1). So the . is
> > > > replaced with a _ .
> > > >
> > > > #define YT8521_CCR_RXC_DLY_1900_PS		1900
> > > >
> > > > would also be correct, but that is not what you have in your patch,
> > > > you leave the _ in place.
> > >
> > > Alright, I didn't realize that 1_950 represents 1.950;
> > > I thought the underscores were used for code neatness,
> > > making numbers like 900 and 1050 the same length, for example:
> > > #define YT8521_RC1R_RGMII_0_900_PS
> > > #define YT8521_RC1R_RGMII_1_050_PS
> > >
> > > In that case, is my patch still necessary?
> >
> > I think it is unnecessary.
> >
> > If you want, you could add a comment which explains that the _ should
> > be read as a .  However, this does appear elsewhere in Linux, it is
> > one of those things you learn with time.
>
> Hang on.
>
> Is the "1900" 1.9ns or 1.9ps ?
>
> If YT8521_CCR_RXC_DLY_1_900_NS means 1.9ns, and the value is in ps,
> then surely if it's being renamed to _PS, then it _must_ become
> YT8521_CCR_RXC_DLY_1900_NS, because 1.900ps is wrong?

According to the information I obtained from the manufacturer,
the unit in the register is PS.
In the code, both 1900_PS and 1_900_NS are correct,as they both
represent 1900ps (=1.9ns).
Therefore, there is no need to change the existing 1_900_NS.


Regards,
    Yi Cong

