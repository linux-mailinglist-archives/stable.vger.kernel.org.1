Return-Path: <stable+bounces-55932-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 717B891A220
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 11:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2E241C218C5
	for <lists+stable@lfdr.de>; Thu, 27 Jun 2024 09:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC57313A877;
	Thu, 27 Jun 2024 09:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KDSuQTyF"
X-Original-To: stable@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6083137932;
	Thu, 27 Jun 2024 09:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719478975; cv=none; b=pKOuvO3hslc8hia3yavl9RoLTa/0qPhifNOcoTR3y8RU9ES1hTKbHkp7WhZRZOKbuDrxLfnESXzabbNMhn3VMHfkpwNfMNzXGkEec2w0X0h6N89qba6kmEDfFrh2lcyyZTEYYsIQpSG1rAP3s4TmeoVnZDWMql/ez0rXhf1ceEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719478975; c=relaxed/simple;
	bh=AXr8LOxjXCxo04s6yQgcKl9EMQEHpGRyMKWbxFVXdMA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=QLUWTu6w1fv+Dd8+Y44p0iFiMaouHGwhgiIHJQz6SkjMGmeaXlYJNOPDi6n8o7Gc9D7sWGeaQmpLz09o3N7h2UYSuC2NbfYdMmpWoW7FOsKPyw3q3ZKKwCFYWXbgi10oG3Yv4xwmuaFXjgV8FNdNXWd7gPMsB9HQMewT0TYtBao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KDSuQTyF; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1719478952; x=1720083752; i=markus.elfring@web.de;
	bh=lNAU4ZrBouebgMYq+EQ9UP06r5NrQHboyM8PRW23Ifg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KDSuQTyFu/aCKuy16MFGNmQyl26I3aCKRHKxCyP4guEt+qg+kLiAhewu7bjs7sbK
	 7TueNniqqeUSbo4wkAWLP2VFQv+sChH1s5SmRVQZTu39l0D0VFy+YXWXI9JluGaKZ
	 8vZdFYBsjMg1Jh8F5eoYqlApUxgCJb6BCUP6sDFRy/9oXpYBNdgHCaeo5OLXU5GCB
	 yDbIhk5KFhIilW1HHVj9pBWBh8V2NNl7ldinBpfqqD83f6mqKI0YwoVYoZnnswqAa
	 x3TXqXwRKid0IHiRApdwxK3CybvC73m3QAAomj5Ni3XMQ8rDqn/TgrYabcRxFY4zF
	 lfNu2QxAZK8L20rvag==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.91.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MZjET-1rrBoF1NPL-00Q5Gq; Thu, 27
 Jun 2024 11:02:32 +0200
Message-ID: <d0bef439-5e1d-4ce0-9a24-da74ddc29755@web.de>
Date: Thu, 27 Jun 2024 11:02:30 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ma Ke <make24@iscas.ac.cn>, nouveau@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, Ben Skeggs <bskeggs@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Danilo Krummrich <dakr@redhat.com>,
 Dave Airlie <airlied@redhat.com>, Karol Herbst <kherbst@redhat.com>,
 Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 David Airlie <airlied@gmail.com>
References: <20240627074204.3023776-1-make24@iscas.ac.cn>
Subject: Re: [PATCH v3] drm/nouveau: fix null pointer dereference in
 nouveau_connector_get_modes
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240627074204.3023776-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bBMND2dRohOaAbnQheA0eTytmh14vaPQz2LLerDMaB8xchrWvT5
 A0iDGRRNOFa6jQOvPzZJlW+CC+W21kzFDyDC9s7llKCGUg4XmraB3dlzRCrvg82GhU5o6ns
 GG6aWd+yTCA3XGxMA3wiO86okmI81F4ycTBQgXGB2Btq7ITt6+EbamM3iQG2JkLDlDXXTs0
 FGEDE6rWM21MmrnOfn5bA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:iq3U0hGjdrY=;i3aclESytnqb+3ezW6st8sRH5Q1
 +7Bynnl7lHUgTrZmFonXxACYyjiE66jJOhmGR6GOrAei13cOjilIMErfEOzNbxiWB6MaAiRSX
 jgNK87y6NEW7E5DBvw483sifxrwD0d9E7zuxlnWGd0DCW0Vd23RUqPocdNDf+D/+uRhUME5+6
 Z6e1Zb5OiaMLoriskNwnkTTqTszRvrJoVu/QcktIJBSSl8PJHXiAm7R8jtwulmTMqNPhHkNMM
 k8kP545WhidR5V5sdf89SJxpYb/zpX9J02ZgfNLmb2hg+5E4vaS/rHkvYBfvZFSJz7foEQ8xy
 gJE52owAf6TqA9uTuA+N18cpP8kbUQXsrAts3JfO4lNpbiHHMDNXyLMTG0Zma8YHGA1cZLQcL
 k+ogBL72rmOdZluYLbaVib9Xvhds76H+H7w/6LBSG8YSuGmVADuxm011Hf/eEMCBTTjYUCeZi
 dGZbryt2h0c1KI2VunC0acWgwHVxrcq2Q8p2leZ39V048DUN6KrpEuRHOPnS0vJUIR7rF6gaE
 4vB1ITqNeRUlkNrkHq1TK21cJFvdPGVOQ2qOY/T0HIrfrA/9o7n6mp0ZkmG0fDG1utiFFZlxX
 skSlvh38QzNvFItY07eBqRQOakE8+lCXyXfwcdKujOPOOTh51YXBHqMmmowHy7wvUuzQM5aPs
 39iie+YEodXGn4LQA+pqqEHH/ZSDIA2CqINIiBMd+e0ubybAN0P0vCT1+OlI7/euJ7OGTiFgp
 7+OxvogfFVPaOvqvYKMjOE6Nu/Jq3/bMvNhnwM8pbunMVqTpWkRXCuT/PzVyqQKRFVvOTdy9U
 pN2TKQAKLlSitASzeIPcnKnxzb+t9Zli8trJFefgdpFIo=

> In nouveau_connector_get_modes(), the return value of drm_mode_duplicate=
()
> is assigned to mode, which will lead to a possible NULL pointer
> dereference on failure of drm_mode_duplicate(). Add a check to avoid npd=
.

A) Can a wording approach (like the following) be a better change descript=
ion?

   A null pointer is stored in the local variable =E2=80=9Cmode=E2=80=9D a=
fter a call
   of the function =E2=80=9Cdrm_mode_duplicate=E2=80=9D failed. This point=
er was passed to
   a subsequent call of the function =E2=80=9Cdrm_mode_probed_add=E2=80=9D=
 where an undesirable
   dereference will be performed then.
   Thus add a corresponding return value check.


B) How do you think about to append parentheses to the function name
   in the summary phrase?


C) How do you think about to put similar results from static source code
   analyses into corresponding patch series?


Regards,
Markus

