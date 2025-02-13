Return-Path: <stable+bounces-115111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D960A339DB
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 09:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B711166AAF
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 08:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DAE20B7FF;
	Thu, 13 Feb 2025 08:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="HQ7+NrMY"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEE513B29B;
	Thu, 13 Feb 2025 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739435020; cv=none; b=tM4ZHbYvJQO2HXDnChkg91Yn3NWPZLDghQkwtwGilgtlTSzadw7JabI56ib14dDy9MDMnUAq6rSmT79kHnTzvOU68oWUGKJFZFC8g4Y1lVW8MkSMW5W/DqdbJP642Rjca+Y9Ui91d2V4pyFbefJCU7Ll10Y1GjQXP8LfvKtR2OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739435020; c=relaxed/simple;
	bh=qBkG/072U6g2ZDiyqvJVpcsyySyyplju3KaLZv/FChE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=r37mjAhkuNQGUKxRJvePUCn/6jV9/HKubVf0PuQtgt/EYl1RIeX0CxHHvEAQJRSQ8msnBzMC92UT8AV3CpxQdUX8OnjAACJp99zrjS6TbzSfSR3dC0aBDmnc/WPYBXvVDULWlP7wWQd7nVE5uWXSW8n5d0MidX5tFjfGZBGv2yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=HQ7+NrMY; arc=none smtp.client-ip=212.227.15.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1739434994; x=1740039794; i=markus.elfring@web.de;
	bh=VMxGfvboixOQ6mR8XBWjIu/drCCOK0BX2fZLkdIjAJk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=HQ7+NrMYykZNXB+p7PgQZFwP0d2MhsBuFEIgw/f4t/oTiUIJrJNvBLYNpXPWCC/t
	 8gbUh4qMXvDg6rqiroF86YiA+zWI/+VDbEH6uODyC998k/g1Inhs7Qq6NBWZYt5zO
	 Hc9705lSDt9pIPH8/Em5ZmP13Wwbd90Ql47aXg+g2DR3/YhH0AQrnXhQWm+LXBxXU
	 EFHyRsfXWHco87XMABbktBsBbm/X85yeUMepa8eljqqUIvWU2o1MCRYeiki4zF6zr
	 /lpL5/4ZghsZ3IpA8bwuzaqoquzt9uPLm2V3aVp7fPonuWJU6lrvbEY8Ey/nTwq1i
	 RIy/cIODYIIULInTAg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.78]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mf3ug-1tBuZM2MLy-00ntzO; Thu, 13
 Feb 2025 09:23:14 +0100
Message-ID: <cb503a4d-c942-44ad-accb-242c10e2d503@web.de>
Date: Thu, 13 Feb 2025 09:23:13 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: vulab@iscas.ac.cn, linux-sound@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Cezary Rojewski <cezary.rojewski@intel.com>, Jaroslav Kysela
 <perex@perex.cz>, Julia Lawall <Julia.Lawall@inria.fr>,
 Takashi Iwai <tiwai@suse.com>
References: <20250213074543.1620-1-vulab@iscas.ac.cn>
Subject: Re: [PATCH v2] ALSA: hda: Add error check for snd_ctl_rename_id() in
 snd_hda_create_dig_out_ctls()
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250213074543.1620-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Xa64B+x8jxXdsSTA9MT7mz8cNtk+94oMr/BCjxdLk2LtJ9iT25T
 J+ydW2WEyGCIvHo+VADz30jSLlX5LISSIVon/yJVPOwOeTrwL9JIWQ+7WC1/sdjAG2p6swl
 Zb+H1MsxR4rTfMkilzLnY+LS/1PoNcubrXqHODD2bNeh6yg46rGL/I/PTvc5PRXXRMV3vHR
 RFpLhV0JDjvJzfjkQFnlg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XdS1vi9NveM=;J7t31MrsF9L/QTgHaNf23SYaVLy
 KhINC//JOlFug8YS0NuFSueStROLbbLTPoJ/NAmvg5PsZde/5tmvD8+/VZSWiDBNdjluDfVfY
 cbXxLq9jsbPu1HJedzzTWkhDutbsUPQFabeWtOgMYMYGnw3w28eAv7Lqb6Smgnj2/yEVMpF3S
 GHc1nQQ6Amn+QHJjS6q111AAKge0mV7UZ0DcoYDIpiYdJm4Gt8z8PVFb4NwHuJAjufhVgX+3o
 lmuxMZHCL0BzGAqyW06A1H4Ep/z7/HCVbuk1URSn04Knaze9xCV3Bne1WU+wZQzJ45uw7J05C
 Hc6RuLghPVdXQe9D0pvmiSlzSW/KeRjwUMx1RLaz4Ls3AEI1rnT+ZlWlKUUVaJuXTuBEo1KZn
 ZPUUxl18JVmZIgxtOtu/++Ogoe3M+YOsK5Pd0Rldu4wlDZ3i9KTbnXu4Hx08asB2RBD4lGyC7
 FWlwhWhSAuEPDuHBdcjX09+k9bx3rTjPkyJiAtRayBpeEAZi+ZtGwlo4BqvjHw0ata8kCdDBy
 arxoIFjVVvnTE8lC0SmHcKahQi1bAQmVlj2GbdMXl1Qzxw26cWQ3JFqt35lDVzWsm7jMifQ5h
 Sg+qiV/c9/JUQCL8aFNXj4vOUtfLNbQP5GMZ/q3dHUKyEH2D9OcHbIFr9R0zbUNttwPMcgi1z
 PUsm3Mc7zgJmWFkdwk8BOa3LBYG8Md6aWKHkMdlkEggA2dnjGSLcU+V/sHLNr2KzXlKhzxAUP
 ogarV2JGl+GKehtm8FRN9TxzjI9GGng8gDydygtOp5CMzzFSNNmftF/2JsitweD87HSPX0jiF
 W7sqjcjhixEUCzd9OXI5L8ntiDCAwDkVncARK+K8tmB4HTDWCG/ksAdyyedF+7WvDCBPhFYVK
 +e2ZtPD7z/yz79U7D6JPumpcAfh9OyGQQlD0WYmKbYV3GOFN7B48RZdL2GOcCRSYi1e+SQ2kU
 MM2N/q4tvZHCnWve6B3G3S1cdbEduUr/KWa5WCysxPsVsanFVs+jBUPUdir0RKRfQ7kBNYBzS
 f0FKQXdFd5Xg+ICRbvadqfW+hAJIw0uow/gp5o2xyjCGzZFLc/ia9n5VYlzTN08QU9poDUZ7/
 r77Eojor7KnFb50VMkdCJCTS8EX2Ipa5vH1gbUUWGMgHZz70nVt+HPDoiAeqQzVH5xDBCD8Uo
 GVUwJZc0jNMyESebny3ZIX5aEM9PErnKXSBIbUsxp2sCiQ4hVf0roC80NE8SkptkPiDNrepNc
 msGILA31fjsWZ0A8XCIaaYFBIM4VbESsgZw0byz+vFstX0oyYIi2NC0deGv9bbDc4x2frYYRM
 8HEgidYkiFowzeCCCGaplbEWCkCi1gY1NU2Sq3gzU+JQh1jg15/p2AJYKQ+5H92MNq9UEZWdf
 lpghJG9tTdfVoN1L4abBM9enAP9n1xKJ8fb2p0oNbrtbMPQ8rmkGVV4rxuXrrEFPJvWYQPORn
 s3VsEI4kv97X1ztjxzw7I9kOHECk=

=E2=80=A6
> ---
>  sound/pci/hda/hda_codec.c | 4 +++-
=E2=80=A6

How do you think about to improve also your version management?
https://lore.kernel.org/all/?q=3D%22This+looks+like+a+new+version+of+a+pre=
viously+submitted+patch%22
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.14-rc2#n780

Regards,
Markus

