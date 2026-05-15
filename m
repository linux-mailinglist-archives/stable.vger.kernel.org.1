Return-Path: <stable+bounces-247724-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SCdLO4YTB2rgrQIAu9opvQ
	(envelope-from <stable+bounces-247724-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:37:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7997154FB05
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 14:37:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3C8D3089B74
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 12:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3151B3ECBC7;
	Fri, 15 May 2026 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N6zWw+wM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIu2pZTk"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC90399351
	for <stable@vger.kernel.org>; Fri, 15 May 2026 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846576; cv=pass; b=apk/m0hvmZlIqsk6Nl2B8DiVfu42TmL599rTNvmNy5eou0AUx+M+CNVA/NxoVZc+xFObpRZV7bpEkSGn7VjuGNEG0c72iFl0EYpEj1mjwsuychrjwXEJQPHMzweUbB6rBamUgA49E4pGRGUJsG84RttFuPqU4jGhCjpIHbSYivk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846576; c=relaxed/simple;
	bh=v1sYLhamZKMYqMtzetvCBeUdkaONDasZIdkC6+MTpbY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tIq+80ROLAPESpKYNA4M0eLUAvsvqpRJwJ8fwHMlyuA+yCQpSBh3kholt2AwLu1I7e80QXTL2dD00EyA+zHRuh1VGkAU8f6jd6RhVvlR28KzV6b6L54ajk/YcPtbWB5ceSEe4lO8/v0mffnlykJi5MuriHiPiLL57jtc5iFNqtU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N6zWw+wM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIu2pZTk; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778846573;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=v1sYLhamZKMYqMtzetvCBeUdkaONDasZIdkC6+MTpbY=;
	b=N6zWw+wM82YpPnohiXg9/SH72d9XeN8PUSP/kbLyNWCD7NK/7eMfWzONyLKmIiFtuPEKoV
	6GufCmMCRZOI7Xwv0g2mgO4lifHPkq2a0tkRRJvujg0bRjorcHL9p4IPw3ksWicrNvPP0V
	DhM0lTz8Xt9Cr1i7Qf6Nvayqpc0TTZo=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-BeclE36uOXewbUfXleDDfg-1; Fri, 15 May 2026 08:02:52 -0400
X-MC-Unique: BeclE36uOXewbUfXleDDfg-1
X-Mimecast-MFC-AGG-ID: BeclE36uOXewbUfXleDDfg_1778846571
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c8271fb4407so7156182a12.2
        for <stable@vger.kernel.org>; Fri, 15 May 2026 05:02:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778846571; cv=none;
        d=google.com; s=arc-20240605;
        b=BzKpL71uhLZquQcF/OSf40q9+ZrQUyUxcBzXYGp4ed/6Xz9myoFhjH9Vk893G17Y1d
         9XzvTtm0GD0d4p9PgKq3jBVTERxe8yxFuwlpLiZ8/km3QCZLBdkOvkwpDL4LbQ3mTKDX
         I62tJbPSTiCg2lpAbsmyPzdsxcS/Ni9X7F7SW3Jlf66nHLx4prLC4ThzNnIwwhxHLEQN
         dUUEZwIpoFW2+Tir1lBdJzXN7qtu8RmOEtxNYWxWXGnfx1EO0fGi4xkieklNRe6f2KxY
         jvxlz4SYHspyevpeM2m5O6Y1iUm/uNUy7oIU0Uz2wxZulcOppV4Zn4+wVMrrnlxLVtr4
         VSLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=v1sYLhamZKMYqMtzetvCBeUdkaONDasZIdkC6+MTpbY=;
        fh=Ly8jjBzwyClBZMjQmET+YRMdDSbZaijLd1xIk49TrnA=;
        b=LRo3/HJw5BP81bsrv+XCZ4ZrWNTj8VSEN/vIIrAKuiaaYNrmUPh97F0et3B4TdEMH8
         jOaDrbQ6K40SGgbtX9qYpMjF5Yf5kOLjXStKJrgcr6U7vC93MfYvKGtCzycJilSv62ur
         xFQzn4UQyyUPeuNsY+EhtF3D8kauNg0I8RDhhvMolw3+bCeU9W+3lxADm+Rqo0drsx0R
         9JIcapW2onJGiOvXkxf0fIhB6Rs7Z/EVO3EhZWf/FVfaywrf9M5X1G0q/WcQOEXMIWyG
         mu2yV4Xf49ZFphCW2Tql63XNVHUY7KlQMrGvUvLWUIWiC8OyAQTpOhQ95i60LdLa9KYn
         URtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778846571; x=1779451371; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v1sYLhamZKMYqMtzetvCBeUdkaONDasZIdkC6+MTpbY=;
        b=fIu2pZTk9ScSRJesWcJ20dIULE+n+lMCxyWQPFZ3043hLxwV7tNWBvgHlE7pIgCwbR
         09roVbmxCzikEp11WjwfziGyMx41d2tPD6khaUVxR+C7978LMJTqevWO7h+zSQG+eakD
         W6fhhGDWrD8IdYM45fvuoUfpag7OXLAtJM/ipe0G7cl2JzyR9KdFj6GEt4T2uJt8h2pZ
         Hyxs/+TFHmud/Pe24EpqH6078OzxPHJls7/Jx02OrZshi3rJ2ykngkCuSfOv5pmIGLUq
         rPwZSLR4w462yF3a3FF8K7drCJ+9I2FNhYZJzvSWO0l5omNqxRatq1fq6Jo5mSw3zgzg
         /vmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778846571; x=1779451371;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v1sYLhamZKMYqMtzetvCBeUdkaONDasZIdkC6+MTpbY=;
        b=iStuEfwL6xsvKC6Elah2jRcKa4VqBDP8ixrFPUpSRqwXemuoM226EeELHf3FYfKr9I
         y42kQcmDw4uaPYoG6D+LFXtkqRgxj7ySNbdntE6d3AnRc7VnR6fbEQxg6aQfKZw9SBL3
         flhPCgr0Q62O9eVHbDzBiXTtqgeBxG2lW7NpB4aqaUc9SjtgWKmSvTxKMHkXaiSMK0Ak
         NptedOKA1YjaCovPB85mQHFtyDZB+mExpv+4OFaqHYJK+w6glfOIDOoquY5YAe3c8ZHO
         0t6I5RHXAox3g8T65tvKFbrq/Kutbwbex2WwPdyTJqaPiH8UraOY2DOfXFWOIShPvfUI
         q/iw==
X-Gm-Message-State: AOJu0YwkE4XW2V6XIA1jIosX4r6uuLkDL+rWNgSPd28uujipI82B2N1/
	QlGRULga/9LTlSNY6ppzjzKL1F0FTM5gvwCAqPkg7nA46xrjNN/Dqam/cRanzNm/Z6INVALdcxN
	cL856Mksu8b2m/0BjohXHdzbaH9A8riOeue5K4WkMCNxJuNC7g4+1AjieAzNE9N3WREMoNTqKrp
	TDYxqtz5R2InKz0YD1Bk2uOpcrktw8ISGwOob6R1rLrYg=
X-Gm-Gg: Acq92OGnzv8u4TE40O12uH1sHeZ6C4wByo0MEZF31IufwGV7snbhxzIPfCVd9C2N0bW
	GTMAgYO0lBci3z8H2otb+8DtYm0JGUUdx35tZ3Mce+4YuhofBdwbm2EdfoxesZlRCgH5gxlpQ17
	0bhSQVFpAhOGHULLnrZl3SpFOIJArA5SNs8CIqTcgvs+xs+xWybRtFW9nITsHhRkv8aWWrDjgfz
	ykk/hPb854x4IPnik/J11p7B71d5JMjxLv/hKDTuTXmf8CVVg==
X-Received: by 2002:a05:6a20:a111:b0:3a3:a9b1:e12f with SMTP id adf61e73a8af0-3b22e84f38emr4399439637.21.1778846570642;
        Fri, 15 May 2026 05:02:50 -0700 (PDT)
X-Received: by 2002:a05:6a20:a111:b0:3a3:a9b1:e12f with SMTP id
 adf61e73a8af0-3b22e84f38emr4399322637.21.1778846569763; Fri, 15 May 2026
 05:02:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Luigi Leonardi <leonardi@redhat.com>
Date: Fri, 15 May 2026 14:02:38 +0200
X-Gm-Features: AVHnY4KF0_f_BUOlHP8TiJa7z356U318-DioSxsj8Vn0T4SGyIfGpgLPdU_EwFQ
Message-ID: <CANo9s6mMchuAN-_9nWofGJq=mbRYP5X4ctc_5-Bis_-Z-zwnWA@mail.gmail.com>
Subject: Bunch of vsock patches for linux-stable
To: stable@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 7997154FB05
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-247724-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+]
X-Rspamd-Action: no action

Hi stable maintainers,

I realized that several vsock patches have not been backported to stable.

They fixed various vsock bugs: incorrect buffer size clamping order,
wrong length/offset and empty payloads in tap skbs, unbounded skb
queue growth, and an accept queue counter leak.

CCing the maintainer in case he has any objections.

d114bfdc9b76 "vsock: fix buffer size clamping order"

This applies cleanly to:
5.10.y
5.15.y
6.1.y
6.6.y
6.12.y
6.18.y
7.0.y

5f344d809e01 "vsock/virtio: fix length and offset in tap skb for split packets"
This applies cleanly to:
6.12.y
6.18.y
7.0.y

does not apply cleanly to 6.6.y, I'll send a follow-up patch.

3a3e3d90cbc7 "vsock/virtio: fix empty payload in tap skb for non-linear buffers"

This patch requires "vsock/virtio: fix length and offset in tap skb
for split packets" to be applied first.
Then it applies cleanly to:
6.12.y
6.18.y
7.0.y

059b7dbd20a6 "vsock/virtio: fix potential unbounded skb queue"
This applies cleanly to:
6.12.y
6.18.y
7.0.y

52bcb57a4e8a vsock/virtio: "fix accept queue count leak on transport mismatch"
This applies cleanly to:
6.1.y
6.6.y
6.12.y
6.18.y
7.0.y

does not apply cleanly to 5.10.y and 5.15.y. I'll send a follow-up patch.

Thanks,
Luigi


