Return-Path: <stable+bounces-216648-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDvdMDRgkmmUtQEAu9opvQ
	(envelope-from <stable+bounces-216648-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 01:09:24 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 231771406F6
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 01:09:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 871403001B70
	for <lists+stable@lfdr.de>; Mon, 16 Feb 2026 00:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2ED72AD37;
	Mon, 16 Feb 2026 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HqvX0NIf"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B716625
	for <stable@vger.kernel.org>; Mon, 16 Feb 2026 00:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771200378; cv=pass; b=bPXMt1eHHXuI74zkNsuA9ve4b3jeNDvtUArRU2CdY+I3D+OmFJ9pWOoWjSP3cozOSTWk6LDBXFV3mHdFz+dEwGdDAzle++mcglcGBI470HcttLlGYttXYck4OWZUcXcNCiNE4nqFHpRzhTjFtwbz6uYbpOmDa6Ld5xjgXcHNaGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771200378; c=relaxed/simple;
	bh=Dr1KWNAuRDOulMLc8w+lzLoSt8lrkb2jNBdZR42gWvk=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=lpqRiAVaVk9+QT8I2ePn5cIYMVY4ppM63y3S5UhZEWqXe+I/T39w3jQvBAzVvFnPxsSJ5Sdnjr29rMAS51WSTRe2Xy/6MnIKgEei9/rDqw/niUcpKkvneMSUup3AP4dHFIAo+OfQDQNZgajpIEyQnzjE/rvkFSMLWT6PQuKZsmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HqvX0NIf; arc=pass smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-7964f1405a0so27544527b3.1
        for <stable@vger.kernel.org>; Sun, 15 Feb 2026 16:06:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771200376; x=1771805176;
        h=to:subject:message-id:date:from:mime-version:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WifWIe4gCYXTyj3CSC85WTGTnQxnGiSL/QIqHzjf7Eo=;
        b=DEvLk8D/otBDv5vo1LhhbZgxU3egZ4tJHwRfgYwbUxgi/9lmkf3BXtChzUt5Y6K81X
         W4AE7ajcdvonGshmlFAzvvW2KfsaWSg9exBvhsjoVwHK8ign6f3Xlb76PldWNptTXwQW
         NQv/KQQMzVrvhuyFPmaZX5hiqfbTnzV3hkZONVLLalWIW+PbFZYw/87K3xGOQnEWGZNG
         NgMF25ncGJwtnqpSrX3x9lXxCGE1MQrDuVkohWqun5CuoJwQSvBeuDOoeCSeUohnkiyb
         OS2S2pXFdzMZMSjLR7jqJvQn/qRSyQsaRkqkEfeELPqKML+B/1wbNTVOmjHsCYRNx3Sv
         lAqA==
X-Gm-Message-State: AOJu0YwAA2IM1to1EXTA9MYU0QwR015Q0b7hU1TmB6KQF5wusOBsgdbo
	1H0qvV8wHOczmIewd9X/gIwfdZrU24vc7vLdMhvbqVAhud0i5J/wpfeLp+v4trt5tgZ92hqQFTA
	R+RerT7EL0ckjNk8XUgyyyqVEDDCtCOOKDeLsQkXojZBf+KOM7vaBeVj1+CxYOw2h8J0eee/0Y6
	nB2xQISQOXWp66t4/3TurrYgYOt+cMBfTe7sK0JT2sGWyBfGT7HntvPk4KcrhL3SrvCteXjAFI3
	f+5SAeXTOA=
X-Gm-Gg: AZuq6aKLgbdqqu7MH0h/WKzuLLXjkY805sQYRGx6/Bdc9Yc1ZP0jgPibFgtgv5yNBr2
	JatdRrmtuq97wPADwVmwGp4IhGIdYRMAoAZo8YmiAwy4HU7WhkiPV4W0iOu+X0bCsE6zm2pGE7H
	p9aYHfUYxYeOaM+ODSwcxdTNMUPFsiwcF5mLAO0YT4RglHFX93D/l1apLssdJbWFHQOofCan1HO
	7m8enJWm1AGlBakTrO8wAk1bDGjQPJZLIKp0QH1Vro9nci7UrX13cH1zB72pDg2rs88cBJ4sByM
	q1toX+UZwmTgN5V/lGfq7RYY75gbGeExhwED00lKHxyBXX5mQi0T0xWFr9Y/lWJAuLf3CkRXqSl
	Xu7dLe0ay6BVKFBMLCcegcEPs1+18Ya4TIQ42D9r+VyOzdum5d2kD99drwt4R/hA9jaDNGK4+fT
	qf9gltMa6oVilpkIxzErjoGzYtFXdb86Lr7sDCD2CLqAnJOV+jfg+CN4fNmgQ=
X-Received: by 2002:a05:690c:4a13:b0:796:6e88:30f8 with SMTP id 00721157ae682-797ac5d7eb6mr48530767b3.35.1771200376415;
        Sun, 15 Feb 2026 16:06:16 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7966c25f4f1sm13909037b3.27.2026.02.15.16.06.15
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Feb 2026 16:06:16 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b8842248611so325093566b.0
        for <stable@vger.kernel.org>; Sun, 15 Feb 2026 16:06:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771200374; cv=none;
        d=google.com; s=arc-20240605;
        b=g3/UV0lOr9UEDYupsHtQSKvl+KW5rl+PMUNaCTGNJz11PbOb1U2k88syRBdanuSLZV
         zHs/MIFco2V0l3PjvhEnwtIRWidSo6ajgI9P9OKNeT/iY9nZuILsjwO7uoGfbwEu7wif
         quZpHQZFBpT4/7wl7b5GlY2OF/q72v1CHKGf/Kp77zRK0wIdp9DzKilmpdHw0TGCqQeb
         ySWSKJQNRUZbbxyye9aCg8vkvg9IU+by5TqpKJkD0GkASlpcdwjEsT/BVHrxcNzJ7jcY
         eHdD9rooh99YHVbLQ/D1A3oborw9iOn803ha1h9eCxBBX0r29fyD9cUnII0E1U3C4/tH
         VNnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=WifWIe4gCYXTyj3CSC85WTGTnQxnGiSL/QIqHzjf7Eo=;
        fh=RvEWwL4CdzthXqFPrJY1v5EhszSUJtREhzms1oh7XMQ=;
        b=VPM6wwQZMc+V2K0hC3uXjJFA5cxS3j6ErnaGSVkH/oLm9cMc23P5XrOWc+EmkSOfTZ
         yr5pEb5rGMXZD8zqJf3/nTj8++tFlD5wqcg2rk0Ksz8oL4a6K8Tl45GfKWXm/Fc5yBaR
         Za5fKQ/Uo7qmYuhjsTB03GqS2jG79v6KDIN7bndYLu84KAaNHqFt4JmELgbwLqrY41og
         N09SptVzHM64RiIHMIzPBtZplvMXvkOcPzfqn61KQIYs9sA8dCNgxiol6or14FTmLNFU
         o4GKz94JaJTV324pdlREZAdYLFAmqJV2D5IWqi65YgqSq47Cc9I+jPitLqZuoX+JLb93
         RuxA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771200374; x=1771805174; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WifWIe4gCYXTyj3CSC85WTGTnQxnGiSL/QIqHzjf7Eo=;
        b=HqvX0NIfcLbC3y28htKl5PeRazM2bmrYFbC7sQyFs5rlOmfRhD/IxG+TaHlCgDlhwI
         jkro0nMuG8lKzOAMLUGtLAJU0IVxulQ9yUIP0p0gzEPf+W1QeOaDhhxs+K3gYHGrYOpF
         KH7NxEcGh08G9VlR0aVvRn4dbACYqqRvFBwSo=
X-Received: by 2002:a17:907:3da4:b0:b8e:7d43:ede9 with SMTP id a640c23a62f3a-b8fb44cc036mr451359166b.44.1771200373867;
        Sun, 15 Feb 2026 16:06:13 -0800 (PST)
X-Received: by 2002:a17:907:3da4:b0:b8e:7d43:ede9 with SMTP id
 a640c23a62f3a-b8fb44cc036mr451358566b.44.1771200373401; Sun, 15 Feb 2026
 16:06:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michael Chan <michael.chan@broadcom.com>
Date: Sun, 15 Feb 2026 16:06:01 -0800
X-Gm-Features: AaiRm50xSD2_5z-IaGln0HxcGU_Ccp6PrQlP-mrZP14bm9vcphW0SP1HOYXP3Bk
Message-ID: <CACKFLik3qQ46i3_wRpm0OnaNnMcMc-hVNrFt_0U9yzzjNrm4VA@mail.gmail.com>
Subject: Request 2 bnxt_en patches for 6.12
To: stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000212e2b064ae5b969"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-216648-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	HAS_ATTACHMENT(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 231771406F6
X-Rspamd-Action: no action

--000000000000212e2b064ae5b969
Content-Type: text/plain; charset="UTF-8"

I'd like to request these 2 patches to be applied to the 6.12 stable kernel:

8ff617513996 ("bnxt_en: hide CONFIG_DETECT_HUNG_TASK specific code")
0fcad44a86bd ("bnxt_en: Change FW message timeout warning")

Without the patches, an annoying warning message is always logged when
the bnxt_en driver is loaded for every device.  With the patches, the
warning will be more restricted and logged when necessary.

Thanks.

--000000000000212e2b064ae5b969
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
DPVtLUtep/P3evQuAtTQRaKedjamBcUpJ7qUhBuv/Z07LlLIlB/vfNSPWe1V+njTezc8m3VfvNEC
qEpXasPSfDgfcuUhcPR+7++oUDaTt9iqGFOjwiURxx08pL6ogSuiT41O4Xu7msabnUE6RY0O0xR5
5UGwbpC1QSmnBq7TAy8oQg/nNw4vowEh3S2lmjdHCOdR270Ygd7jet8WQKa5ia4ZK4QdkS8+5uLt
rMMRyM3QurndiZZJBipjPvEWJR/+jod8867f3n0CAwEAAaOCAd0wggHZMA4GA1UdDwEB/wQEAwIF
oDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSBhjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3Nl
Y3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEF
BQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1Ud
IAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgwQgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIB
FiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAy
hjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjZzbWltZWNhMjAyMy5jcmwwJAYDVR0R
BB0wG4EZbWljaGFlbC5jaGFuQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNV
HSMEGDAWgBQAKTaeXHq6D68tUC3boCOFGLCgkjAdBgNVHQ4EFgQUJbO/Fi7RhZHYmATVQf6NlAH2
qUcwDQYJKoZIhvcNAQELBQADggIBABcLQEF8mPE9o6GHJd52vmHFsKsf8vRmdMEouFxrW+GhXXzg
2/AqqhXeeFZki82D6/5VAPkeVcgDeGZ43Bv89GHnjh/Vv0iCUGHgClZezpWdKCAXkn698xoh1+Wx
K/c/SHMqGWfBSVm1ygKAWkmzJLF/rd4vUE0pjvZVBpNSVkjXgc80dTZcs7OvoFnt14UgvjuYe+Ia
H/ux6819kbi0Tmmj5LwSZW8GXw3zcPmAyEYc0ZDCZk9QckL5yPzMlTAsy0Q+NMVpJ8onLj/mHgTk
Ev8zt1OUE8MlXZj2+wgVY+az2T8rGmqRU2iOzRlJnc86qVwuwjL9AA9v4R13Yt8zYyA7jL0NiBNP
WaOSajKBB5Z/4ZVtcvOMILD1+G+CVZX7GUWERT9NRXw/SyIEMU59lFbuvy4zxe3+RbOleCgp3pze
q8HE2p9rkOJT3MkCNLxe+ij4RytIvPQXACsZeLdfTDUnjeXCDDJ9KugVhuqMelAZc4NissPz8FOn
2NK++r5/QamlFqYRhsFxSBIvhkh2Q/hD3/zy4j17Yf/FUje5uyg03FblSBOk2WYpRpXEuCpyn5pb
bYVIzfhQJgwGfO+L8BAeZIFjO1QL3s/zzn+RBlTl4wdDzh8L9eS+QEDhMcSsqb4fFRDbsoVuRjpx
R5MunSUzk4GcmmM19m7oHhPGeKwIMYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UE
ChMQR2xvYmFsU2lnbiBudi1zYTEoMCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0Eg
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCB79vqn
yesrHPXDZNyEyQTrMEC24N35t5Ast1R7urPIDzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAyMTYwMDA2MTRaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQB8jFgtJjNwIJmYHugPtaxVreXnWXgJJui8llLsiukx
6+vnlXRUA9VGwxcWrdlOIZZlu9yP76AF2F9iiCmTAiY6s8b4gFef7b0jTeTp8HXNJbV3Mpg1/oc9
4MwNCYtKjtGC/9JdWRq9N6c0jHZFn1wM0gQRmYtX88LdC9uB6mAyPNADPpK79it1euti1OoMcbag
OZ181AgWONuFOij7dCZ/BEYmP0//uXg/A04wkGCb+yrE/4jkpwCKJ1v87qJBwFwQimgZ82qIiCG6
3ucI4uu21tIkYlT3lhCxr25LrBabs564ZTiICeCCNqSu2wTFU+4i3yZP5t7vNry+tfcynxVP
--000000000000212e2b064ae5b969--

