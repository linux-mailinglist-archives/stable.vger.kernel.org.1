Return-Path: <stable+bounces-67445-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CBC950194
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 11:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19CB2840FC
	for <lists+stable@lfdr.de>; Tue, 13 Aug 2024 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F135117F4F2;
	Tue, 13 Aug 2024 09:51:40 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from cstnet.cn (smtp84.cstnet.cn [159.226.251.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC44210E7;
	Tue, 13 Aug 2024 09:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542700; cv=none; b=AxPLPGW3Fbwjh/1hY6dYHdYjOAVIkZYEsvqi11txQAg48pTRBb1tTLWH2H9ZVWoKX5nLyH6kcIuiXp+Jxg7a0WURMSGX1T+Gz98c4+9B7byLHTCRIL6Z8a0Kymrn+t1Ku5Q3r0lIkdDbYbYEelo1kp0L7D/8opwIlyrV/maRH8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542700; c=relaxed/simple;
	bh=y7i4xYrA1KjsFT1X7da5xZ5+50BNyhyi/XIePc62P8k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mbkayabLyHqM3RuCApSGk3Ck/l8XCakOq9RR0JXmqywRKxqj4Ix5CiILZmoLkWWlxfTt77Cmkt52Aw1II0ANjTe2zoWyCrZcquI7eRCB5G4x0n2vG1Ucd5bTps3P7k2O6qBg2kYhk2h9EswOHDPsamNUVDG6pobPBWCS5UV5Cys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from icess-ProLiant-DL380-Gen10.. (unknown [183.174.60.14])
	by APP-05 (Coremail) with SMTP id zQCowADHrTiaLLtmTDTuBQ--.46534S2;
	Tue, 13 Aug 2024 17:51:30 +0800 (CST)
From: Ma Ke <make24@iscas.ac.cn>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	christophe.jaillet@wanadoo.fr,
	giometti@enneenne.com,
	linux-kernel@vger.kernel.org,
	linux@treblig.org,
	make24@iscas.ac.cn,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com
Subject: Re: [PATCH] pps: add an error check in parport_attach
Date: Tue, 13 Aug 2024 17:51:22 +0800
Message-Id: <20240813095122.4005722-1-make24@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2024081336-escapable-anemia-87cb@gregkh>
References: <2024081336-escapable-anemia-87cb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:zQCowADHrTiaLLtmTDTuBQ--.46534S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy5KryUJr4fAr1rtF1UJrb_yoW8XFy8pF
	WkCa4FvFWDXF9Fkwsava1UuF1rZ3W8KF1UCF4UJ343Z3Z8ur1FkFy7KryF9FyxZr1qya45
	ta1jg3Z0vFW3ZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC
	0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr
	1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUAxhLUUUUU=
X-CM-SenderInfo: ppdnvj2u6l2u1dvotugofq/

Greg KH<gregkh@linuxfoundation.org> wrote:=0D
> On Tue, Aug 13, 2024 at 11:08:00AM +0800, Ma Ke wrote:=0D
> > In parport_attach, the return value of ida_alloc is unchecked, witch le=
ads=0D
> > to the use of an invalid index value.=0D
> > =0D
> > To address this issue, index should be checked. When the index value is=
=0D
> > abnormal, the device should be freed.=0D
> > =0D
> > Found by code review, compile tested only.=0D
> > =0D
> > Cc: stable@vger.kernel.org=0D
> > Fixes: 55dbc5b5174d ("pps: remove usage of the deprecated ida_simple_xx=
() API")=0D
> > Signed-off-by: Ma Ke <make24@iscas.ac.cn>=0D
> > ---=0D
> >  drivers/pps/clients/pps_parport.c | 10 ++++++++--=0D
> >  1 file changed, 8 insertions(+), 2 deletions(-)=0D
> > =0D
> > diff --git a/drivers/pps/clients/pps_parport.c b/drivers/pps/clients/pp=
s_parport.c=0D
> > index 63d03a0df5cc..9ab7f6961e42 100644=0D
> > --- a/drivers/pps/clients/pps_parport.c=0D
> > +++ b/drivers/pps/clients/pps_parport.c=0D
> > @@ -149,6 +149,11 @@ static void parport_attach(struct parport *port)=0D
> >  	}=0D
> >  =0D
> >  	index =3D ida_alloc(&pps_client_index, GFP_KERNEL);=0D
> > +	if (index < 0) {=0D
> > +		pr_err("failed to get index\n");=0D
> =0D
> No need to be noisy, right?=0D
> =0D
> thanks,=0D
> =0D
> greg k-h=0D
=0D
Firstly, I would like to express my gratitude for your valuable suggestions=
=0D
on the patch I submitted. Based on your feedback, I understand that it is =
=0D
unnecessary to output error messages in this function. If this =0D
interpretation is correct, I will make the necessary modifications and =0D
resubmit the patch v2. Thank you for your response.=0D
=0D
Best regards,=0D
=0D
Ma Ke=


