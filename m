Return-Path: <stable+bounces-250026-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALXRKKvrDWrM4gUAu9opvQ
	(envelope-from <stable+bounces-250026-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:13:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2AF8593187
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:13:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9E26F306890F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 16:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B892363C4C;
	Wed, 20 May 2026 16:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhjH+cZK"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82AAC356774
	for <stable@vger.kernel.org>; Wed, 20 May 2026 16:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779293733; cv=pass; b=U1S1DEe49JKJ6njVnfHWKM/+4ZF1kt4uUjFkA9Rs25ytV4pMhVF92ZAPKuc6A3E2gckAOpQcLwrS3Dt86FoyOnaPvnLLSZgaxjanZEAGXq/XGclzZRBT3+vsi6VPhteFqThdSbkUSxANgh936fRY0trN1pkvlsOzUrObK/xLJZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779293733; c=relaxed/simple;
	bh=JKxF9mERknSE7lZLZj7DBF4Zib3RcqW9UlhDD1cBWUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PI9RUuDsJCuQCbksd41T+FFZ+9VYFdaxRYLT9u7c86B6KEMBybB+7TKHx/g52Pi3tt5jEhnklPfbxqLoYw/PGtOivS2/nP2WJPdY5iA7vFC8TsaDLGWXvHQ24QuS6hFTcyBQ72fcP7foZ2NQbO7/UzXgmgDOVfWjE2Vn+PR6Csk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EhjH+cZK; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7bdec52f48dso44375087b3.0
        for <stable@vger.kernel.org>; Wed, 20 May 2026 09:15:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779293731; cv=none;
        d=google.com; s=arc-20240605;
        b=CTVM9oBbzHR/h7R20ysrVhTIYVWjMkVqJk8OzpUX1GcepbCU4GT1biOFIyC6UxScS7
         n0S/K7j0cJLn3w4pY4UAa+7qd8/Qie0HP439S82UqLqKsfZwKz4VkIp1hsf4M3lFexm4
         IU4ix4bjyr7yOHLHCIa5kJrbqiDcZEkyep+f85j1Wc6zp87xzNS0eBy0B2KiRwmG3aUO
         cJYWviJomG16EQ1sj3+nWACYgoj80XSt/UEZKbTzUjKFPq72Hkbqqi6ybi8IwxQxnxW0
         ewi94p7vAte+EiCtOpR6gudqSngT/3RsvPxlps4X3j129GWbGyYyCFHUfjjC5Vh+CEoG
         NO8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/SwmHL1mQ5O2rtM+DnQgsZYSD2qH9aA6RgcLHzFBUdM=;
        fh=IOtxM/2EMIAmyHJKeX87xXHDFF/7xyWR5V+MvdM9qoA=;
        b=ajzNLfAB82Qd+VLI7/W7dumDwuuPUofWWJhsnXshW347pHOkDjagVYoIejtHuy2fkl
         46QATNpVYHpIQ7We4PDd4HNv5pXTxnUb2fY5kPrv5TIoUlTGQpR/kBqdzZ9y9H0ple32
         Mrpb35T94EDi64lVsMSyc/XFafZfhpK2D1ToFV4Nu0B1t/L8OQkCqgNa9i83hzpmcWCz
         KHCyLPmKXMGcOb+RpZ1CWtFYRSuw/4E9IiSVg7WsPCBACLlTeuKsiDDhKU3T36Ds/LG2
         1zQEFXWemNLesD6QXHOdOCq7zA7BdT0EQ+8VxNtn6pIBVRW1efzy4Pl9aTpQVa5NkAgy
         NzqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779293731; x=1779898531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SwmHL1mQ5O2rtM+DnQgsZYSD2qH9aA6RgcLHzFBUdM=;
        b=EhjH+cZKPdEndbn+7kRyZHPDnnzrFnTR4SHe2y7EmzUb0RTmv2+Tuqu75lqcNdFTS3
         8DZ/pxRSU5xOZTUCxhlH9B+OjRxEU0QiosY//r8ujDXTU9s55Ha6jJ9yVVpaz7jBvBmG
         zJx4ID/iBtHAX5lf7JTq5+Kzkui6x7PcY/zTrqGbzT94agZANpjraoK8Gcs+0QibsmJC
         43u9MkNDKdyq+X8Ks+bU/ijLmB3fVwwWtc8wotntwzAJnbrzgqeAoyK5R8pUlw68tVfZ
         CTwIhsqlztwBkL/Xb+dEjGBeSfEAcdy4BPwifT+d2ZOFDlYDAU402nLpxWrL2InvOImW
         sK7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779293731; x=1779898531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/SwmHL1mQ5O2rtM+DnQgsZYSD2qH9aA6RgcLHzFBUdM=;
        b=SqdAtrc0eDGGzDuG2u/zOdah9zK0xOaIgtj6YOcL9T9z0TXCM3wZ17mY8J04XwQUSC
         cYhCn2kVJsGBERM695PFpOVimcRZcv2Vi3Xyixpw2P6tLYa3Mk8YtKwQX+GFvujrILyx
         9gofpWa0PxJMr+cqOYKLXdQzZm4XkSR4YIWKj0yw0VONMkqIQtZHlzwEiVJ7/WdNSFNj
         AELtuIoQi2mzG17bHWJ9LseiLYi9wIHHCKSzAnKy4jySPdV06yDQRUhiErkGbh1wNahJ
         DYbxPf2E/R/Sow0uCK9jLxUOYNcE9011PjM6LbucG7fSZDJz7WEUbfD0bJGrIJDkfpq0
         0gAQ==
X-Forwarded-Encrypted: i=1; AFNElJ9GBWO78m7oWF0SG3VK1rl94oVWbSZepCnFt0ErPp02DpazBt/uvgb152i34hnOd+cuArqdFNI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp4U6JRtuX14bCtGLF+ZnrHyxCfhvV7aTSvReB8byeueyf/E8i
	4qbx6YuKc4fvdryYvWv7stBUNzAbTO91HgF82yEf7DMZBLuNaf9df6aGl36OFetui+v280O91af
	8sTq6NftYMKKPROmSolzhCEHTo1qIwVE=
X-Gm-Gg: Acq92OHsTkrVWUTHyoYmJSdL6vxZgcPOWGSBMLw0T9bDoWwRa7TLOIegITX40vC3JtH
	9AZqA1rgAtnpl6uHu58BJMpImXRqg5hoObdWjb1n56QWE+d/gNZ70zDYynm+hb71sOEw+rPb9tX
	JdaLDGLtEXCYFwkb2y/qleNYpQjmQRCd6tkVjQwBnatBJv3MJxLVZvm4EPeNP8WhswAnf2mvdUG
	qb2dgrEP3DeLi3DICyomWy76CxJQojkJ4RfFLEL+JFw4ogSnCfkMOrP5HIl5u9IeY5Txj1Zb8pw
	E/mrN6wvX2EMWYtfstYPWWWMIj6RSxvpSm7rRChKWQcuC8m+E+h7g4kmL5vm0xqdvog=
X-Received: by 2002:a05:690e:480e:b0:65c:6f05:ae25 with SMTP id
 956f58d0204a3-65ea8363d6emr97017d50.30.1779293726841; Wed, 20 May 2026
 09:15:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520135034.1060859-1-michael.bommarito@gmail.com>
 <CABBYNZLLw=VFfjaF_TXA=5ZgDt7rw=XgUULoc4JudMpUBf_BWg@mail.gmail.com>
 <CAJJ9bXw9r2XHYMkmjbJ9XAiGEG3VEWK6bjKHbHgwJqnOBzTu9w@mail.gmail.com>
 <CABBYNZ+q1c+3Su_3_ib=zbVMD35tgwMGjdV3OwM5a3GXOq1aRg@mail.gmail.com> <CAJJ9bXykBr1FQP8++kUL7ceXKp2u92+zySCqVEQqCm_+KLXj0Q@mail.gmail.com>
In-Reply-To: <CAJJ9bXykBr1FQP8++kUL7ceXKp2u92+zySCqVEQqCm_+KLXj0Q@mail.gmail.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Wed, 20 May 2026 12:15:14 -0400
X-Gm-Features: AVHnY4KLzY6qZrOAlROfkxchLK6iuGJuEWScellTpWFEb2rNkqndHXLtgHsJKfM
Message-ID: <CABBYNZLzYGJgq=U1AHm-xL_hMCaOFVrJTnSxyqQiqjKQ3JUowg@mail.gmail.com>
Subject: Re: [PATCH v2] Bluetooth: L2CAP: reject BR/EDR signaling packets over MTUsig
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-250026-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizdentz@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: F2AF8593187
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Michael,

On Wed, May 20, 2026 at 11:23=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> On Wed, May 20, 2026 at 11:19=E2=80=AFAM Luiz Augusto von Dentz
> <luiz.dentz@gmail.com> wrote:
> > This coming from the spec is priceless because silently discarding the
> > packets means the remote stack won't know the responses were
> > discarded, causing the stacks to go out of sync. We also shouldn't
> > process packets beyond the allowed MTU. Therefore, I strongly disagree
> > with the spec requiring an identifier on the reject, as this implies
> > that even if a custom MTU is set, the packet must still be processed
> > if it exceeds that MTU to find the first request command within it.
>
> Should I keep a verbose comment string about this rationale in the
> next version?  This seems like something that might trigger questions
> in the future if there are issues between Linux <-> noisy/buggy
> stacks.

Yep, be as verbose as possible, and quote the specification whenever necess=
ary.

> Thanks,
> Mike



--=20
Luiz Augusto von Dentz

