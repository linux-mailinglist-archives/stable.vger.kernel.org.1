Return-Path: <stable+bounces-226925-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EDSHOTHbuWlHOgIAu9opvQ
	(envelope-from <stable+bounces-226925-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:52:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 630A62B33AC
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 23:52:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 995173061CFF
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 22:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55CB43E715E;
	Tue, 17 Mar 2026 22:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KExUI77r"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f225.google.com (mail-qk1-f225.google.com [209.85.222.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846063A6406
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 22:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.225
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773787946; cv=pass; b=Ck/MWH9AOGjj6/0oVc2+q+EBDBfBQwSje6j1yi3vN6af93Xf+SACpjIhUO6Vml1xNfU607zRB0vh5idDsreQ4CPPuvhztAIbaaelNEexdnjJdABIIAYufUa7dpBMUpdSsgWUEA/qe7aa9lFkx43X88+YXhyAObECx7XP5Znw4Ac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773787946; c=relaxed/simple;
	bh=ap2bqnc0JttuhOleeqw8EHvVuX2fnWBy7HjmyakVnkU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmgq87qQ6wcct8kQYSpGqG3vEwtNC4ZWfwGC6QvaTUonQ9nVF/iEe9xeRvJxlkruQirZiXRA7fxbKB4fzXuzcBz15zzzRTPhp96wMyfhH5jfD9Sk3VubZ3dHq3GCEUvTgLFngwvDz5Ovm1VEH2yLqdlxTqMGp4F2wBgVw0eFogE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KExUI77r; arc=pass smtp.client-ip=209.85.222.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f225.google.com with SMTP id af79cd13be357-8cd8576a512so41855585a.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:52:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773787942; x=1774392742;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VimHESGtLk9A//oIrH9TLAZvgO4QePLyaoJdJw23eao=;
        b=WdJ4wvP3aR1IsGq553U/DBvJIGilGPMw88G0Q7CvXQ8w60YR9zAQD9l3p3ertYaixF
         u7jlWWX6hvlgdT4R0nWZCBEdPp4d7ibFEgEm1XYJOSYAMkw3SIATPwiGVD+28TKCs9Eu
         tbw0IrCRFjtNf+F6L77d5B8Tj6Wbl47wJFa+tDwl8jPaXTLZ4N5oQDfaKP4+OzBDWANi
         5Dh2CzCu7RWVNGLSvscpB6i+UC/LZGFTEPsejtyeqlp2vwBgXeAdnVRFutkPP8LV88tP
         SU9qdk0aeulbPW5/bSQ3vEtS3v1yqtn1XNa7jFN4tzRCFDi3dCWG0BBBp9K5mT7ZCVk/
         cI+w==
X-Forwarded-Encrypted: i=2; AJvYcCVsVSDGkALDTET7ALFw5BqbSN8PBDplR7KM6G8ar3HmrzGE1kll8Z38JFjIxdTAk4Lvki88AxA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL7LOTcjnF5mEPF9Alk/F7knya7vcHHl8FA0vlX5ATYLbuy4Lc
	8ugpR0d3CA/Mvx1fpS/h9itbZh4jxTRifZZVfyqi4UgUBrL/1TqoHllwUfwj57B0/8BwlLEErKn
	dTRfAvPUdnya6H/nocN13dfdiROVyRfgdgBjQs18OStUHb5hGuwhUcevbGUwBdVFN8/Xornjst+
	1L1RaIT1sMP5mOwCBD/ldXiq1FVLGJI/MP672Efk5wtTY6KwVGfUpRqi3x2Hh947BxCIOTXLXWV
	ZaIm1xh2o8=
X-Gm-Gg: ATEYQzyILx1aawLrblWDMleR1/2O96rUHcyHAKo+v+BzDIY5CfjgfkqN9dpLyS/reyL
	vGPiWDVByeBe+bnTo2afqFIt7OZdxbVqC7+qmm5+trzWxAChEHpN1Od+DVwtrctqRz8wRF8w29E
	rbMCdGds4te7BQgmoJzfDuJJ/+QscKpc3wNNLiwUOjPC3zmdgrx63jJceZIM7mam9ONy9naKXfg
	nA+GQ6Qd4lw/onJDlJCIk9FMtLaRXPnAqDiPxWJZxr9Fd10KfWqrNUDCAxT3xz8DVwXtYr1drpe
	1nKjNU2tTTBomrUfLL/miEwal9TV9hQb+f+KMTONrBtLI+Xz7kwJHIzmYXzHWCP+Sz905R6uQbi
	sZbJ6T/ZlUYqYqwNK5bCIccHtQtJ5jvtCM9NEBYPcbD026G6MZ8CoXn31OOl2KuNlIwxCzhYLki
	DtvrDu2e7Qg34b9AQKxKHVyctG06lBWfEV5EBc+kQbEq/4NcW+KcTFDn0ehAY=
X-Received: by 2002:a05:6214:4113:b0:89c:6263:3c25 with SMTP id 6a1803df08f44-89c6b2c95bemr22538416d6.2.1773787942423;
        Tue, 17 Mar 2026 15:52:22 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89c6b8f5ccesm929786d6.11.2026.03.17.15.52.21
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Mar 2026 15:52:22 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-b97a381912eso193492066b.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:52:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773787940; cv=none;
        d=google.com; s=arc-20240605;
        b=cQbgaCLzVeA3/qtP6v8qxQ3nM8ch+JYf7k06ehEXZQLP10clQJiVc/eRV+hdox7XIJ
         h28/RrXCSvudpc+Xg02x5QsefY0vX1DhMt5NUNT3C7UYnaZp3cubeubRStkwMAH3JJzD
         duTZ2+pAI0yPiW0gr9ehzi+TZS0PWhDrI6P68JAEgzoOnJ7HXAcaI23GOUW0w4JuwsNO
         zUh01FrnseVCCmNGMRBwg6DkwlhpAf+kp6VZhGGjfjMTncop/WIfqPegN44hmtkdoQxK
         dhQRx5KKtaQd4eEbzF4QIF+3uvq3ppLo0AZ/pe9wpaKhmZMn2CjmFaQfBafiPnQ4vxHl
         yQ9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=VimHESGtLk9A//oIrH9TLAZvgO4QePLyaoJdJw23eao=;
        fh=ImlcAZvTh04bOVWZih3ekggVSg7jar/ivy84HMjx9gc=;
        b=SkzAw4QJ6rFaHd/pvWEbuIs+21Q5IzeDVHVgsrow18Jqjpo69ALpWI/9qKqTYaOh0T
         qFK3fDkbdMlvsWyS+DlEiVihPb40+upJPYHUw6fOMsGnNs8tpgP5VkK2OBRb7ezcMXDN
         rMbGHg6A0E4HsIT9LuMmuwEN+b4aJvTCCj26lzt7bTSpZzcU2jAAebkwh66UJizJU3fO
         EIZWWQLcMHllyGRPSod7XTOyYGe+tX2RDlblZOC4ggBQRmVOB8yFMkeqg/sRoX8FDAHp
         8Geb96lMIPCrdDr3Io2GeBcWvRxcdoHNDFvKHFVOAU2MJkt4jtR/cqmzOlh2LOmrTq4b
         BOCg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773787940; x=1774392740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VimHESGtLk9A//oIrH9TLAZvgO4QePLyaoJdJw23eao=;
        b=KExUI77r+7hXFudBRUBptYjbQgv25a050JBmEtN4fAoYrD2RydumPMH3NP5gYIUifY
         Ju17M8y2FtuSgvHGi3X4hf8p3+gLrVWuYVCkMzrgDuJhw1/45unYJYfZyJJha3hFR+7W
         Ff6omWz23awg4UyrtjEoi3MPjKSTjnRjRvPUc=
X-Forwarded-Encrypted: i=1; AJvYcCXHnip6VHBb7vyWPZNUJtZ7ighehnljRQY2x9i5mTwjj+RBIzn+6IeJoNc4Nc+X5NOv2Vfr29I=@vger.kernel.org
X-Received: by 2002:a17:906:6442:b0:b97:b20f:c5b2 with SMTP id a640c23a62f3a-b97f48a52bemr46184666b.9.1773787940530;
        Tue, 17 Mar 2026 15:52:20 -0700 (PDT)
X-Received: by 2002:a17:906:6442:b0:b97:b20f:c5b2 with SMTP id
 a640c23a62f3a-b97f48a52bemr46183766b.9.1773787940033; Tue, 17 Mar 2026
 15:52:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SYBPR01MB7881A253A1C9775D277F30E9AF42A@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <20260317153824.7671cfde@kernel.org>
In-Reply-To: <20260317153824.7671cfde@kernel.org>
From: Michael Chan <michael.chan@broadcom.com>
Date: Tue, 17 Mar 2026 15:52:06 -0700
X-Gm-Features: AaiRm539f8Dh0P2Ax7YyMWesdfFUftMaooSSn1hYuy01v8z4mniNwzKrw8YSGto
Message-ID: <CACKFLik538mb-K-SJqkZwpQECySjfeYknuP59g7YJeqd81bZXQ@mail.gmail.com>
Subject: Re: [PATCH net v3] bnxt_en: fix OOB access in DBG_BUF_PRODUCER async
 event handler
To: Jakub Kicinski <kuba@kernel.org>
Cc: Junrui Luo <moonafterrain@outlook.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Shruti Parab <shruti.parab@broadcom.com>, Hongguang Gao <hongguang.gao@broadcom.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000202c15064d403012"
X-Spamd-Result: default: False [-2.76 / 15.00];
	SIGNED_SMIME(-2.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226925-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[outlook.com,broadcom.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michael.chan@broadcom.com,stable@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,broadcom.com:dkim,broadcom.com:email]
X-Rspamd-Queue-Id: 630A62B33AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--000000000000202c15064d403012
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 17, 2026 at 3:38=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sat, 14 Mar 2026 17:41:04 +0800 Junrui Luo wrote:
> > The ASYNC_EVENT_CMPL_EVENT_ID_DBG_BUF_PRODUCER handler in
> > bnxt_async_event_process() uses a firmware-supplied 'type' field
> > directly as an index into bp->bs_trace[] without bounds validation.
> >
> > The 'type' field is a 16-bit value extracted from DMA-mapped completion
> > ring memory that the NIC writes directly to host RAM. A malicious or
> > compromised NIC can supply any value from 0 to 65535, causing an
> > out-of-bounds access into kernel heap memory.
> >
> > The bnxt_bs_trace_check_wrap() call then dereferences bs_trace->magic_b=
yte
> > and writes to bs_trace->last_offset and bs_trace->wrapped, leading to
> > kernel memory corruption or a crash.
> >
> > Fix by adding a bounds check and defining BNXT_TRACE_MAX as
> > DBG_LOG_BUFFER_FLUSH_REQ_TYPE_ERR_QPC_TRACE + 1 to cover all currently
> > defined firmware trace types (0x0 through 0xc).
>
> Hi Micheal, looks like it now does what you asked in v2?

Yes it does.  Somehow I did not receive v3 from Junrui, but I checked
lore and v3 looks good.  Thanks.

Reviewed-by: Michael Chan <michael.chan@broadcom.com>

--000000000000202c15064d403012
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
MjAyMwIMZh03KTi4m/vsqWZxMA0GCWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCCPYQ4r
MhVndRQV9m6WtgpOGQ5+DMyvKRW2wnMjWOngMzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwG
CSqGSIb3DQEJBTEPFw0yNjAzMTcyMjUyMjBaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEq
MAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCG
SAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQBxw0IqYs8Kfq1HQkG8q7WMSdo5lv5VlPqD8NGHp0LQ
gHbXLefvRMHWX18CPvP8IcXNCGDdwkPCPqOuw3EjFI0RPYcFig2luKGlE8C0RqJnWqUhM1mgKZ1g
/FMUq9sE1KTovkTYuMdewMdF9k4QT03I5l5itQV5JBCbADZn+9PLdpzDfnq8z+DDWoVKSIeHjGS6
QXn1sQKmg/qWu1vZN9hzKPkv5GvUdMANY38ljONE/N4Q++lG1nSYKzk5dOcsL9VvY3nuQDNQsGrg
zlSRpUDR5vTe5yCoA7Wl49RpgH864xq4S/pkZ4Yyf6wLGqDjeuopThddcIb1i6eDj2p8LTKQ
--000000000000202c15064d403012--

