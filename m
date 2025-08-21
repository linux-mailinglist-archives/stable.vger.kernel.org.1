Return-Path: <stable+bounces-172231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94024B30806
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 23:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7F9A1D043E6
	for <lists+stable@lfdr.de>; Thu, 21 Aug 2025 21:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D6DB393DEC;
	Thu, 21 Aug 2025 21:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="tP7T+6SL"
X-Original-To: stable@vger.kernel.org
Received: from sonic314-20.consmr.mail.sg3.yahoo.com (sonic314-20.consmr.mail.sg3.yahoo.com [106.10.240.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E920C393DE6
	for <stable@vger.kernel.org>; Thu, 21 Aug 2025 21:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=106.10.240.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755810141; cv=none; b=XssKgfNhac8RN4DNWRCcLew9Q7a8pxlYPZiHKqSolSGuCiEajo/EsVCRa/nHtS75NMmkrjvoMli5CsPFVSVuodR4CHfrCHoPZiNPS1lzROKanNmeTP9kLSSZdiOODS3okomsyiDGHEVYKMSRHUGkabbmx2E9yTlGwveoO4Ftp0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755810141; c=relaxed/simple;
	bh=o/QW5Eq00a5QXAUtM52Knv7Z7ah1Xkh2S53OzkGeLmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9Npe35Z+tpCt4r8tGkIiTb6Tx0PTEewOLBHfiPgq8wPFzjqnH74Wf2qilsWXGuQh3JNKgOvVD9SQNsjGEude788sL8PFhPO3dwRLeJCJG61x7iGTKJEAYc3UfH2nQ9dnclcaOMlXWRkYzAGlwC3hJS0aDr0ztAsBT3k7BybyAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=tP7T+6SL; arc=none smtp.client-ip=106.10.240.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755810137; bh=vBI/OWLaWKWrwJL5r562JGOYuxBdZwPCSQTwe/bG9+o=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=tP7T+6SL80gLeVgWlTfxuCPq2Xif+sXhm9z9YoU3E4I/x/8LH0fPUazRJze/BXwqySpFBJHq1nf3KOzxfEHhTcXD4DwJO6jxQ2Rp7SCzstRN2PfJjszFBEG449U0QYd3zkj6KxY+DngDR5s0JD/bORWfxHlpONnOV5zw+dHxd0ZgZ4Nj7MAEOEg/w99Mh5WxQrmY6jMgNf0E4q/XAJhb4ba5lO3KPvkXot4TX7NTNXuTqIawD4gTnoznFYOu98SZhiaAqb5KD7E/ASM6cEqRns7l5dn+VrcjQx8A532/aVQ6AY7Fcb1h9oh4gG3WpKh1ivjYYbNlPfaV6NV8+xohmQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1755810137; bh=oNOWcUMXdRdd16yc4QspODBcYUG7kpTvqwRShVE3F7f=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=Mpa8cDXab7Czb2BwGdGSs8uin8URMOOEaWFibgol6nRaiU+0YUVfkPXy5JUpg52mUpJEgGKI1ul1edi21di5/hNz6SY4wMMmHoLmnmDy9+GKDpy7cSoLSS1+Woz8WtSbthBuUNxtAvnM2fjx+sL/etlwstXX28zlLTghq7LJtHE3g27F2keV8EGIoLxjxm/cd+U1QSn3MZAKwl0FaJGGA/RA5kF4okesFbyTvVZEHPnAvQQGQ+kfphqhJptXQ/iFOJqDUiDbVVk1oZaZkUS0et525kXcPGZWTb6PDtD24pSwyJOXZdoGRsaFocpuk8vBFxjo2WVLJkT9lPIWrfISUQ==
X-YMail-OSG: vWSuLkUVM1kfy4eu59THuypnKreboSQetJiKdBU7SvJytXnwFfl3L.Tzu.MAhQ9
 28sPyt6.IXL8ugM8NdCXEsrpb2SuPOBxdbLHha2.Z66PgyIcvICHLxPEXVBLcfmDSOruVb6Qqlaq
 htcyD9pk9Bk1uBy2_o7wnK9zTv6Jk.MB.jFGcRzwccFCp1ZTEFRqDYPa_iM5.yvRUSJuY5F4jUa5
 oXjq6FMX04b6bSaA1I.JhyaHng_2T2pehNrZtW4.1lci3MBqTWIWw_0nZoPRYbjL6TPGhR1g_bi9
 gOV3ojAJCga5fYX.maaPA18k_SI334Qp9JoQsfSKbgG7QaOsbEYSkweUT4P90gOqqATTA_MNQdLi
 zvPG_2O5MU3AOUfVQpxKaOPa5y8nzQcZkzMyi3Iqy3lFIUjnvHCNt0LJM53E.V9DJwglg15uieGv
 Kx5fCaKAKhfyuuUo6_J1LACM_svaxWC.ZuPVfFAjRsHILOvfKGW9m4w7TL0N71Jh3ty39Xu.RWWN
 Wkm4MiEraB1Y9i4T.0yrgM3OT2aCgAiMOUYk0_CCd02RsSNtXV3o8RNiNnZHz1rMe1xo1sVaNJc3
 0Ako1wwzCKr01PdhNg8NDu96PWgRpnqba2bZOMaVLOgkAec4iOcfAyGWrBNyNUMRUoESH9xnsAP.
 x.R1I5XavcNd34hLbf66kpTiX5n4jVWkydQ413HV1AXmiHho5FkzSLKGKPTI.HWVT2yM.zZJ8gGQ
 ygZQfoOpI4Sj27caq.LRWw.wPFXTQWqXebPgZ_sM4a6EBN97Wq9L8Zvfkc039BdUUYpu7ikO1Myc
 q5iv_07T5qrtBJeXgmJGjILv2wlAJD.pSOa8yH_rXwpKsW0VjOS8manuoSmfstIzRcPLlFZWS_9Q
 Lr6j597U_JizRWV5mdWgbblOP8cAIN383ScnWujN7gCEw766Rimd_.Lj5PECyaPXKRh_W6l7ptl6
 fkvIsGwppLX7rnu0pB9loz0..IE79p6j6yiNFJm7VZjEpKUqssCj0iED4shIDvYVbIyZxWgZcxyC
 xmz4sIPL8SoMAYI84ugy_WikTKeSsoennDB1ouhxMybiXfEvS3OLGdVlhby_AfS0NZKRq303q6ju
 Aa9jpxUvaEn602Mcj14QfQM6r47dPYFC0f7Hqh1LCs5gWVUaTfB4Xz7KXzPp0BNMUub5tgh6h.Yd
 Af_lKR7ZjG7rhBAibZNzI5_96wcEZZNmssm.Wnrhgdzjdp.oJ.BgmLU4v9l.XQzWz6MiKjRZZJeM
 Pq34OxsFtmP8_BRlKWyvImKSy8.QXGGxSqfz.mApefMFK6c58b66av52D7qn9oRSJfweLSAJD11f
 .B8mKr1Ag99xKg74Sl5e0_BimYXcs4XddTE_HgyXCYecIm.R0Pk.cugWxAKbFksI_JUEtxpfH5Pf
 _nONMDyFN189LT1bhrxwnDY7x1auQeNLtSsLEuk2W10OeiIRWPZPWuLuDJH.h.dNFaPCj2KyZRlX
 SfJUnROeYgTbTBpmFB.StMJmW7.lE8cLNwA.PKhuJR8sb5q5YFfBxsy3e3vzPBsG3P4CT78NzfNt
 SCAEXx069UCJ7eIwfKaShERP7tgc5q3Foihwttg_SwgGvblDrUiQEK2vpaBf2fmxJg.wZ2mwrF1Y
 xj_io0JicrkoflwOGHTUcAHfY8nNZJGyYBCCel.ZoIHjFVhz3mc7v3pLgbEHH6Yh0siRUU2WSN.m
 uhO9J1KKpn4OwX0fHW3tyLcw7F3zXigRyXb7CXyzOcdQxusGtl01ugJaCjRBo_aDaGISXpHqD2gE
 QfDVRkttxWMMBGh0nIVkpxe_rXiBn.sA0qs18GrwSEn5BoaJ8t8AgWLTYAreYEMAzOA2Bbs3qEJH
 kURK80zsAWILmZVjnQ5EZPoaN1C1jbGDW1i78zbsUhpgKJAiTIgt2xFPmRH1g6lzshTg.Eq0WyD6
 N3A2oYj_FwV2dm8PjSCYxJ.x7qZhSqPvYT3f0gEa4oOZLFgNDxK1pHXxrXFRBelmQbFL7EUIknLa
 8_F5.0aI8t5P6V3tbw_PAzkAeospn93Ws8ekD3qmf4dBNQFqTScE6CfaAnKEX0QBvuS9FPVfd0pH
 vm9IYSAxGODQ9s7vW9DhrpadpVLFFTrNVTpwxToIN6LorOOG9Jkk08HMLmRsKfp4gXhRPL81jIQ0
 yEX5dQQy66XIs1ghn9YKxH_H3maB0QAenWFB2fN3kYErg1bAxeZQp3GOJOCyXo7UdoA_lU3lDP4A
 NPOPYV0zhrYdYTDGN9NaIMeuTYioZkJPKVZtXtm7epK0t8qFqXkRYsas2utQpcG3kjY2ojwZNkQJ
 5EV2IeItuS2y13npY
X-Sonic-MF: <sumanth.gavini@yahoo.com>
X-Sonic-ID: b855ca6c-ebb3-4909-904f-82bbd6905c1d
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.sg3.yahoo.com with HTTP; Thu, 21 Aug 2025 21:02:17 +0000
Received: by hermes--production-ne1-9495dc4d7-dbtfw (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 63f50e64a47cfa33942b2637b7ef206d;
          Thu, 21 Aug 2025 21:02:12 +0000 (UTC)
From: Sumanth Gavini <sumanth.gavini@yahoo.com>
To: jstultz@google.com
Cc: boqun.feng@gmail.com,
	clingutla@codeaurora.org,
	elavila@google.com,
	gregkh@linuxfoundation.org,
	kprateek.nayak@amd.com,
	linux-kernel@vger.kernel.org,
	mhiramat@kernel.org,
	mingo@kernel.org,
	rostedt@goodmis.org,
	ryotkkr98@gmail.com,
	sashal@kernel.org,
	stable@vger.kernel.org,
	sumanth.gavini@yahoo.com,
	tglx@linutronix.de
Subject: [PATCH 6.1] softirq: Add trace points for tasklet entry/exit
Date: Thu, 21 Aug 2025 16:02:08 -0500
Message-ID: <20250821210208.1724231-1-sumanth.gavini@yahoo.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANDhNCr3E3nUjwYqFq1aC9P-EkX6iPs-X857wwN+a_QK9q7u4g@mail.gmail.com>
References: <CANDhNCr3E3nUjwYqFq1aC9P-EkX6iPs-X857wwN+a_QK9q7u4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

>>
>> Hi All,
>>
>> Just following up on my patch submitted with subject "Subject: [PATCH 6.1] softirq: Add trace points for tasklet entry/exit".
>>
>> Original message: https://lore.kernel.org/all/20250812161755.609600-1-sumanth.gavini@yahoo.com/
>>
>> Would you have any feedback on this change? I'd be happy to address any comments or concerns.
>>
>> This patch fixes this three bugs
>> 1. https://syzkaller.appspot.com/bug?extid=5284a86a0b0a31ab266a
>> 2. https://syzkaller.appspot.com/bug?extid=296695c8ae3c7da3d511
>> 3. https://syzkaller.appspot.com/bug?extid=97f2ac670e5e7a3b48e4

> How does a patch adding a tracepoint fix the bugs highlighted here?
> It seems maybe it would help in debugging those issues, but I'm not
> sure I see how it would fix them.

This patch is related to linux 6.1/backports, the backports(https://syzkaller.appspot.com/linux-6.1/backports)
I see this patch would fix these bugs. Let me know if my understand is wrong. 

Regards,
Sumanth

