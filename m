Return-Path: <stable+bounces-241503-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIghEH998GlSUAEAu9opvQ
	(envelope-from <stable+bounces-241503-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:27:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9657548162E
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6692D31E9C48
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA1F3D6CDF;
	Tue, 28 Apr 2026 08:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L89Or5HD"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f227.google.com (mail-vk1-f227.google.com [209.85.221.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9BB3D6CB3
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777366070; cv=none; b=Tzoifc1hBPM/o9Ng/ja3YFg957leMoYrCfnQmTsB8NQ5ip10YN9tPu/7kcs9Y/kS2wxtiiRfTpZkq0kQuQhdq4qIVDoceEe/KSpaKqURCma1MAQnhRd3Yc+adeLMrSJlaVOuNbQop57aXqT22c48gq9QvGTO/I0TIG3iAqrvIds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777366070; c=relaxed/simple;
	bh=FX7uE6tp7P3QPlSkHQB3htKkBvLIXDup27cfhH0kHvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Isne/rKsJKYb1nZfq76WaN2XByNmOyZByMa5jKpGpm2Bv3x6iCbWVfUnu3p24usFqIDBkQGuqpAfutjCCjvib+tfD2lTbb9vyu5kciv8aIMA6PvFbYK3HIrpN6MK2TPefYj2mezFRTUwhiBRtZcxhufqFKobb6/f4l38Ze35LgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L89Or5HD; arc=none smtp.client-ip=209.85.221.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f227.google.com with SMTP id 71dfb90a1353d-56ee931f78bso282769e0c.3
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 01:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777366068; x=1777970868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FX7uE6tp7P3QPlSkHQB3htKkBvLIXDup27cfhH0kHvI=;
        b=e/siwofdbROIugU4zF3Exr6t3d/KCauAFLNSJyEwaoOLr/YyC4VD9JjanlxI5I4Flj
         elkAT2cNgfuVXvvGVnvHIhufvoi+LziWvmDl/j4FIzQXYCGT4PeunGT5d6ONt+iIc6dZ
         7u3bABaVWU+uqSqaRAf5R+RZzU64SIulVIcQVkhRbXRWuwAGQFI5wr74eDz681FzD3Iu
         rCbmRmLOgmjOja9nAlxmOApfMA6yUCa4RtcvY6UX1S7Dq+ftmol41Yq7zm+vuPU1dg49
         Y5fF3ebCzTO33qtXqqAMbxCbD+JO6jNqC59xdMYWAkfoomL/No2JqvPFNrgo2o8mYmri
         lLWQ==
X-Forwarded-Encrypted: i=1; AFNElJ9fllSPkz2qRoiwsH0ZVGTyC6SB0KSHbDE65/U/hl4QaLD2GyxPffAqM/VbSGXkHvuWRFFwHhk=@vger.kernel.org
X-Gm-Message-State: AOJu0YynoGXUWi+unH3fg5qDc4y4mIYy0JP6v6NVDjqSOtw8Jb2UIEyj
	EmxZtlpKbfjqLvOMAXPuVrVXuUKhDFojp/itJZqsRG4/8n3G6MPbws0aeGyTUz1p4SxjeRRglMu
	uxnDr1KrxPJI/6K4nA7O07S8wma5Xyw5KGR7T8iSSJUHAOilw619KoKPv2MT1kRSLM4HlesNl8A
	QvGjvfbFVdNai162l4jJVTddElhBVv0cUJGwspastaU0jOe8gm4j1QGOBST8o+kI4YfOSdwick7
	njW8Zfqn/GUSDg=
X-Gm-Gg: AeBDieuBNEjJPeOfZEW4FyN85gLwMwD0dBPNgbGZxoy8Lx+/7M2mg6r1UifZF3hOVxi
	VQojPmw/CwEUuLIRp+MGtu8YBB/DPcVtmyfeLa+KGllB7oFLPF1OjgDbkt4XxOUKYEXkVc3Fjy2
	V8IUzmf/SNM6Lo5PlhDyZN2bm7+rGgMkfBMLQdF6bdz9BYfNwbLt/ccyqenl7LHbAZZsImWTDEm
	++yaldmFGIKnDRxfIkxMT6D3Lwv+7zFlNUUlZ5XasbhMxE1UusAheEf+YNniqJ7GNHVFlTxplA0
	Xc86/WnmjYGFpK3Pn58oDaOaY3LriHvemQ2HHi2T4G/DZ0Db4TdtcDQORvgj7ORo8avX/wqxLNi
	QF5T20k0/BOkHJcfI64oYSZryEMOIBSDz6TwTXkV4EZLaiwRm4QuR0QXHTKEcYN2LW5zTeI9WSC
	YP6mdGKjikhj8pKUiz
X-Received: by 2002:a05:6102:5126:b0:604:e96f:af36 with SMTP id ada2fe7eead31-627cfbfbe4cmr507588137.0.1777366067720;
        Tue, 28 Apr 2026 01:47:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com ([144.49.247.127])
        by smtp-relay.gmail.com with ESMTPS id ada2fe7eead31-627f8222c66sm131522137.20.2026.04.28.01.47.46
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2026 01:47:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ba52316eeb2so115603666b.1
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 01:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1777366065; x=1777970865; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FX7uE6tp7P3QPlSkHQB3htKkBvLIXDup27cfhH0kHvI=;
        b=L89Or5HDFe7O9CCQr4v/+JX56trt3bZvpPCgWeWNIa5whVTPaNOdfVQ6M8ObieyKH9
         BkOFcryAH6SG8Kn8LoD6nU0F97OG3HodmKHSLTNUQjVSwB/YY7t+qJ0dRQmcOlckQEAv
         uo5qkuv9RDAT30BowzNyR6apgExSiLifjLtwE=
X-Forwarded-Encrypted: i=1; AFNElJ/fn+/p2YmeEp5PPqWw6m6PorsGxwSsgHBosASweKxG6OGaB4WBRf+lJfmeE/7hHgQm/dYqR5o=@vger.kernel.org
X-Received: by 2002:a17:906:99c2:b0:b99:1070:763b with SMTP id a640c23a62f3a-bb7fc7a9e89mr50436666b.5.1777366065370;
        Tue, 28 Apr 2026 01:47:45 -0700 (PDT)
X-Received: by 2002:a17:906:99c2:b0:b99:1070:763b with SMTP id
 a640c23a62f3a-bb7fc7a9e89mr50434866b.5.1777366064706; Tue, 28 Apr 2026
 01:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427152756.1205-1-ankit-aj.jain@broadcom.com> <CANn89iJOTxeF30wO7+0GoLmMAZGpCq+JUM5EQe5siNfYzEtZkw@mail.gmail.com>
In-Reply-To: <CANn89iJOTxeF30wO7+0GoLmMAZGpCq+JUM5EQe5siNfYzEtZkw@mail.gmail.com>
From: Ankit Jain <ankit-aj.jain@broadcom.com>
Date: Tue, 28 Apr 2026 14:17:31 +0530
X-Gm-Features: AVHnY4K94ZA0UN5hBeqlwWRgBUJwEomHwWwB20WhSUceiS-2U6JwG0HfopBB3g0
Message-ID: <CAMh818JNLZZyGoL0LPURtSQtrEswwUhV=0rmwtREsSO3x7cRZw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: do not shrink window clamp when SO_RCVBUF is locked
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, quic_stranche@quicinc.com, quic_subashab@quicinc.com, 
	linux-kernel@vger.kernel.org, karen.badiryan@broadcom.com, 
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com, 
	vamsi-krishna.brahmajosyula@broadcom.com, yin.ding@broadcom.com, 
	tapas.kundu@broadcom.com, stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000fdc9e5065081484c"
X-Rspamd-Queue-Id: 9657548162E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241503-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ankit-aj.jain@broadcom.com,stable@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]

--000000000000fdc9e5065081484c
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 27, 2026 at 9:08=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Apr 27, 2026 at 8:32=E2=80=AFAM Ankit Jain <ankit-aj.jain@broadco=
m.com> wrote:
> >
> > When an application explicitly sets SO_RCVBUF, the window clamp should
> > not be dynamically recalculated based on the memory scaling_ratio.
> >
> > Currently, tcp_measure_rcv_mss() aggressively crushes the window clamp
> > down when it sees a poor skb->len to skb->truesize ratio. If the
> > application explicitly locked the buffer via SO_RCVBUF, this
> > recalculation causes the advertised window to drop severely.
> >
> > If the window drops below the interface MSS, it triggers Silly Window
> > Syndrome (SWS) avoidance on the sender. The sender defers transmission
> > and drops the connection into a perpetual 200ms PROBE0 timer loop,
> > drastically reducing throughput.
> >
> > This is highly reproducible on loopback interfaces (MTU 65536) using
> > Java-based workloads (like Tomcat/GemFire) where the JVM sets SO_RCVBUF
> > to 32K or 64K. The bloated loopback truesize forces the scaling ratio
> > to drop, crushing the window clamp to ~26K, instantly triggering SWS
> > stalls and causing gigabyte transfers to take minutes instead of
> > milliseconds.
> >
> > Since the application locked the buffer, the kernel should respect the
> > clamp boundary and not dynamically crush it based on runtime ratios.
> >
> > Fixes: a2cbb1603943 ("tcp: Update window clamping condition")
> > Cc: stable@vger.kernel.org
> > Reported-by: Karen Badiryan <karen.badiryan@broadcom.com>
> > Signed-off-by: Ankit Jain <ankit-aj.jain@broadcom.com>
>
> Make sure to add a selftests (in ./tools/testing/selftests/net/packetdril=
l/ )
>
> Thanks.

Hi Eric,

Thank you for the review.
I will formalize the packetdrill sequence from the commit notes into
a proper runnable .pkt selftest. I will include it as the second patch
in the upcoming v2 series.

Thanks,
Ankit

--000000000000fdc9e5065081484c
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIVKAYJKoZIhvcNAQcCoIIVGTCCFRUCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
ghKVMIIGqDCCBJCgAwIBAgIQfofDCS7XZu8vIeKo0KeY9DANBgkqhkiG9w0BAQwFADBMMSAwHgYD
VQQLExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSNjETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UE
AxMKR2xvYmFsU2lnbjAeFw0yMzA0MTkwMzUzNTNaFw0yOTA0MTkwMDAwMDBaMFIxCzAJBgNVBAYT
AkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBS
NiBTTUlNRSBDQSAyMDIzMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAwjAEbSkPcSyn
26Zn9VtoE/xBvzYmNW29bW1pJZ7jrzKwPJm/GakCvy0IIgObMsx9bpFaq30X1kEJZnLUzuE1/hlc
hatYqyORVBeHlv5V0QRSXY4faR0dCkIhXhoGknZ2O0bUJithcN1IsEADNizZ1AJIaWsWbQ4tYEYj
ytEdvfkxz1WtX3SjtecZR+9wLJLt6HNa4sC//QKdjyfr/NhDCzYrdIzAssoXFnp4t+HcMyQTrj0r
pD8KkPj96sy9axzegLbzte7wgTHbWBeJGp0sKg7BAu+G0Rk6teO1yPd75arbCvfY/NaRRQHk6tmG
71gpLdB1ZhP9IcNYyeTKXIgfMh2tVK9DnXGaksYCyi6WisJa1Oa+poUroX2ESXO6o03lVxiA1xyf
G8lUzpUNZonGVrUjhG5+MdY16/6b0uKejZCLbgu6HLPvIyqdTb9XqF4XWWKu+OMDs/rWyQ64v3mv
Sa0te5Q5tchm4m9K0Pe9LlIKBk/gsgfaOHJDp4hYx4wocDr8DeCZe5d5wCFkxoGc1ckM8ZoMgpUc
4pgkQE5ShxYMmKbPvNRPa5YFzbFtcFn5RMr1Mju8gt8J0c+dxYco2hi7dEW391KKxGhv7MJBcc+0
x3FFTnmhU+5t6+CnkKMlrmzyaoeVryRTvOiH4FnTNHtVKUYDsCM0CLDdMNgoxgkCAwEAAaOCAX4w
ggF6MA4GA1UdDwEB/wQEAwIBhjBMBgNVHSUERTBDBggrBgEFBQcDAgYIKwYBBQUHAwQGCisGAQQB
gjcUAgIGCisGAQQBgjcKAwwGCisGAQQBgjcKAwQGCSsGAQQBgjcVBjASBgNVHRMBAf8ECDAGAQH/
AgEAMB0GA1UdDgQWBBQAKTaeXHq6D68tUC3boCOFGLCgkjAfBgNVHSMEGDAWgBSubAWjkxPioufi
1xzWx/B/yGdToDB7BggrBgEFBQcBAQRvMG0wLgYIKwYBBQUHMAGGImh0dHA6Ly9vY3NwMi5nbG9i
YWxzaWduLmNvbS9yb290cjYwOwYIKwYBBQUHMAKGL2h0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5j
b20vY2FjZXJ0L3Jvb3QtcjYuY3J0MDYGA1UdHwQvMC0wK6ApoCeGJWh0dHA6Ly9jcmwuZ2xvYmFs
c2lnbi5jb20vcm9vdC1yNi5jcmwwEQYDVR0gBAowCDAGBgRVHSAAMA0GCSqGSIb3DQEBDAUAA4IC
AQCRkUdr1aIDRmkNI5jx5ggapGUThq0KcM2dzpMu314mJne8yKVXwzfKBtqbBjbUNMODnBkhvZcn
bHUStur2/nt1tP3ee8KyNhYxzv4DkI0NbV93JChXipfsan7YjdfEk5vI2Fq+wpbGALyyWBgfy79Y
IgbYWATB158tvEh5UO8kpGpjY95xv+070X3FYuGyeZyIvao26mN872FuxRxYhNLwGHIy38N9ASa1
Q3BTNKSrHrZngadofHglG5W3TMFR11JOEOAUHhUgpbVVvgCYgGA6dSX0y5z7k3rXVyjFOs7KBSXr
dJPKadpl4vqYphH7+P40nzBRcxJHrv5FeXlTrb+drjyXNjZSCmzfkOuCqPspBuJ7vab0/9oeNERg
nz6SLCjLKcDXbMbKcRXgNhFBlzN4OUBqieSBXk80w2Nzx12KvNj758WavxOsXIbX0Zxwo1h3uw75
AI2v8qwFWXNclO8qW2VXoq6kihWpeiuvDmFfSAwRLxwwIjgUuzG9SaQ+pOomuaC7QTKWMI0hL0b4
mEPq9GsPPQq1UmwkcYFJ/Z4I93DZuKcXmKMmuANTS6wxwIEw8Q5MQ6y9fbJxGEOgOgYL4QIqNULb
5CYPnt2LeiIiEnh8Uuh8tawqSjnR0h7Bv5q4mgo3L1Z9QQuexUntWD96t4o0q1jXWLyrpgP7Zcnu
CzCCBYMwggNroAMCAQICDkXmuwODM8OFZUjm/0VRMA0GCSqGSIb3DQEBDAUAMEwxIDAeBgNVBAsT
F0dsb2JhbFNpZ24gUm9vdCBDQSAtIFI2MRMwEQYDVQQKEwpHbG9iYWxTaWduMRMwEQYDVQQDEwpH
bG9iYWxTaWduMB4XDTE0MTIxMDAwMDAwMFoXDTM0MTIxMDAwMDAwMFowTDEgMB4GA1UECxMXR2xv
YmFsU2lnbiBSb290IENBIC0gUjYxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMTCkdsb2Jh
bFNpZ24wggIiMA0GCSqGSIb3DQEBAQUAA4ICDwAwggIKAoICAQCVB+hzymb57BTKezz3DQjxtEUL
LIK0SMbrWzyug7hBkjMUpG9/6SrMxrCIa8W2idHGsv8UzlEUIexK3RtaxtaH7k06FQbtZGYLkoDK
RN5zlE7zp4l/T3hjCMgSUG1CZi9NuXkoTVIaihqAtxmBDn7EirxkTCEcQ2jXPTyKxbJm1ZCatzEG
xb7ibTIGph75ueuqo7i/voJjUNDwGInf5A959eqiHyrScC5757yTu21T4kh8jBAHOP9msndhfuDq
jDyqtKT285VKEgdt/Yyyic/QoGF3yFh0sNQjOvddOsqi250J3l1ELZDxgc1Xkvp+vFAEYzTfa5MY
vms2sjnkrCQ2t/DvthwTV5O23rL44oW3c6K4NapF8uCdNqFvVIrxclZuLojFUUJEFZTuo8U4lptO
TloLR/MGNkl3MLxxN+Wm7CEIdfzmYRY/d9XZkZeECmzUAk10wBTt/Tn7g/JeFKEEsAvp/u6P4W4L
sgizYWYJarEGOmWWWcDwNf3J2iiNGhGHcIEKqJp1HZ46hgUAntuA1iX53AWeJ1lMdjlb6vmlodiD
D9H/3zAR+YXPM0j1ym1kFCx6WE/TSwhJxZVkGmMOeT31s4zKWK2cQkV5bg6HGVxUsWW2v4yb3BPp
DW+4LtxnbsmLEbWEFIoAGXCDeZGXkdQaJ783HjIH2BRjPChMrwIDAQABo2MwYTAOBgNVHQ8BAf8E
BAMCAQYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUrmwFo5MT4qLn4tcc1sfwf8hnU6AwHwYD
VR0jBBgwFoAUrmwFo5MT4qLn4tcc1sfwf8hnU6AwDQYJKoZIhvcNAQEMBQADggIBAIMl7ejR/ZVS
zZ7ABKCRaeZc0ITe3K2iT+hHeNZlmKlbqDyHfAKK0W63FnPmX8BUmNV0vsHN4hGRrSMYPd3hckSW
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGXjCCBEag
AwIBAgIMbntqa4fWscpa/odZMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI0MTEyODA2NDQxMVoXDTI2MTEyOTA2NDQxMVowgagxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEWMBQGA1UEChMNQlJPQURDT00gSU5DLjETMBEGA1UEAxMKQW5raXQgSmFpbjEpMCcGCSqG
SIb3DQEJARYaYW5raXQtYWouamFpbkBicm9hZGNvbS5jb20wggEiMA0GCSqGSIb3DQEBAQUAA4IB
DwAwggEKAoIBAQDw7npj4cwT0wMDizZ3jWoZvhYCqc1CIVtZRy5zqR8ZZbNbOlYZ6UUVRXUfPMUR
Z9ffkv26gY+mbjapHpQzB1358nccRYXJcAkztBgOuGllq2/67wWUUIM5YZ5SaeqhSZFJsRJJytQC
DaSuWu5q/33nHVcaIJ3kp/2HCYAuxbyy4iqXqiO8/oBCAd7SQzi2IQw7nSYBdNRh6oY2RWDEBBRG
rF53gLnbWUTEN/292ihDLnEJNkjdCJhAS3oytVWYk9OuIi52Q4LleFysRYTymXUKF4HnjuKd7vh1
n1NxXoEjw6364Ls7rJeHCZe4QhPYDyVpKhuqakY3fcGRWgkM/5RJAgMBAAGjggHbMIIB1zAOBgNV
HQ8BAf8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzAB
hi1odHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4w
XDAJBgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDow
ODA2oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3Js
MCUGA1UdEQQeMByBGmFua2l0LWFqLmphaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUF
BwMEMB8GA1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQu6tB0f+nWQaN4
VmZkSjInquwPTzANBgkqhkiG9w0BAQsFAAOCAgEAH4BFO4g2gliVnQ77RMBV9ww7Oj19gFz8tQwS
LvnxwhLen1ZLZdujX4iw3c/ZLa0h8YUQkTbGDJvRLxwQy2A4gSkYsRt7olZR7miNjAkIRmeNJctR
xmONt5SVp2svfnW7bdt01CrpPTbXGnpP48od9kvmJovO/Vafp9orPWkTxMRuyL5qRVli8V+oBeq3
/Ev1RzYJq99dDFW5lNHB1JvwVN5EabT38sbg8kCD3KNRuLYE6Cp28HwJv1XCk6nIdN/aUV3QCTMp
EW+EMajE+KlRiK1s4lMEV2hLjw7mck6qG5d1/npfyvZ3I3SrWAWHM5ZnhTxSfbrw49qE5lmm8Hj0
33zOCQGQOyLk1F2P5+AqEgaBKxjiTsmTlEAnMLSWjZKh3c502uTR2ZWjnNLolvrA0guExR3J70Ks
nYWHGmSY3ZTZIMGCdz0sbnduyVpHP4FtN4IrskURKKloOBNGcfVn3Ily8Vy5Yiojf55cVYuoVeob
6UYJDbHaoDqig6YcfdzM12JCQFCaO8Px34NGinow7nYdfugWbwWM1JU5Ekl+nGFg3J5/aNvN86WR
6uNRdFpfYPriH5/mbuk3LHQ+uT/tgFAM+83PZpHdetKNWJCEp7pwSgnofznlnuMpZ9GMRXIwYwqc
RCyvmPPRUdRsTZjSE+I2283LmfhOEbgE7JDOdWIxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJF
MRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBT
TUlNRSBDQSAyMDIzAgxue2prh9axylr+h1kwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkE
MSIEIBNdOtd0C586igB0YwouhgO97gCeNYBx2KNyIF8LplJvMBgGCSqGSIb3DQEJAzELBgkqhkiG
9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTI2MDQyODA4NDc0NVowXAYJKoZIhvcNAQkPMU8wTTALBglg
hkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0B
AQcwCwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABMtZm3HHSEgnu1/GX1vDuwSJwg8N2Sy
05FZiHG2EHD+lrycAJOuHYTVFsuSGwQcbbiwmbcGDh6ehcmbGYbOtiCrYDkKm6Owz3Sr/5xeBrnV
roT9cnSbu3mKIzCACMMXmdicx70CU6WCTIZEb0INGxmSrH2kx5vRHa8MQAe9yrhF8kVezmXJRqQK
1eHO+PtP/cX7dOZZIZjTkQbU6ONDhPPwOm5J5tT7cqvMf821IrdTrXUnTu6Oz4hpLXoAF53zeT12
QfqoJgnTn/0gLREgjxQiiqhlcc17pXNQrKaxbLpT1lr0/lXswiFu1YO6eqRR8+QCa3UseISBxzT+
0SgGEzI=
--000000000000fdc9e5065081484c--

