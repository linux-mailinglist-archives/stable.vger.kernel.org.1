Return-Path: <stable+bounces-169272-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB5BAB2393F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 21:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FE016208D0
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F17F51A9F90;
	Tue, 12 Aug 2025 19:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="JAnhTjLl"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB4D29CEB
	for <stable@vger.kernel.org>; Tue, 12 Aug 2025 19:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755027942; cv=none; b=Pa6iBDEKm9B1SfJn+axhL3YX2mzSXWlPlEwCBsvGfXE6hQs3J05Zsuz/olnqr0ptFuIMlyT+6a5MhuARVOKh5GylMRpzE9AGeUsGrJ0A5CDmQLVZ2Hqx7aAD0+A0i+/hBXWhwES+BhHOtDJb+rXKIuqEADLfGrw4bLOnNLk1oBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755027942; c=relaxed/simple;
	bh=DGnLmbOKoT79ibAGFbtcq8FdgaOKOB/SrcbK8kUMJ7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lXyw7mZWC5esEoJFxdY2YmX9iPLPZmVQaNGefZd7u4qCc6rr2Zbk4ivsQXVCrJ+HWWdN7+CBF08m4CoSu16RPbXy67q6+JoivGr19gsMCFg9nMfAs5LhESVZIgAXrq1GxrJXbrLGfPtx/z+KNXPeQMCfDYjeN/NDD6VyqzpUVfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=JAnhTjLl; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-709dc76b8a0so10801786d6.1
        for <stable@vger.kernel.org>; Tue, 12 Aug 2025 12:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1755027940; x=1755632740; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=i3/sZ0mZKDi+kN9fzg152zyUDvS/2w4/yR7Fk1xS42Q=;
        b=JAnhTjLlsDRfIXxo0yKaGk1d/dwjMGxbffznkfmJ4ZTGjdU3I5N512EB/Y/tj91D2l
         D8Xs+pWjy7yHKJfMsJBRWCpHhGQ6hd0jd8f27yJzCe1ySS4F0T+i7ATcua1EKxYKUCMc
         HPv/MvsgjberVF7iYnYGc93f3dEsUHJUuAwDQ9zS1kpe2vWMBiA1XxBc2jA0yGnkPhGj
         TKpQg+yy+qCvJTP7Ya9GzbfeKROGwx0dWITGEyMWeqFvezG1Up+E5goP8CQfb/vHVqC5
         Qr4VLOX4P6tUMpU53OQzlA5W+noLpMsmCxhyj+8oHXDpZWC42LOFIbbK4ZRGyCx5+PAu
         kzUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755027940; x=1755632740;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i3/sZ0mZKDi+kN9fzg152zyUDvS/2w4/yR7Fk1xS42Q=;
        b=N7AMv3wd++P+lgDkQWI6fV0EAckq09gL/m+16IfTIiqEBp/sk84ZImPDR/X3eq9+Fd
         ODdxKjwAUIIpr/PISwOzH2T6J61GTMIaCAhvbXzpaVofh+ADsTVKONuf9iD3SVKa1Jj9
         ma0Ch3jogdX9RLFKssGe0OpogX+2zOxUOK1UeOsuooFohjjC/q5px4RBoxtAf5gECRXF
         T2sRgtk4SpwQ1a2dfjZQl03c0rppQixFLU7i/NSjjbRSiww7HT8AVgpOCBX0lmPW3kG2
         w57k9wrzo53RvyuxsEE4fXTtL7tnmN/iwZIs44hkvPZVrtkrIMEhMzkRm94Oe/LF2Wtz
         OC2A==
X-Forwarded-Encrypted: i=1; AJvYcCVjTJr1uXkqsg45GkS7tp2itrLy/8QrJ4/+aMzjLDoXTH8zLoJjGIr6Qa1T4uCpfDRjLA+Q2eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwZXXEbiW85Tv7B5VGs38HQd/ftv4wF0no9eIvUzDXb+tyxKt8
	oa2iHNHkyBslWCVjeBNJJPDXiP2QigUnuHYzVxKgBOnFR95b4s/hwOVajzM6Eln9Hj0zSc/KfxU
	2wtQ=
X-Gm-Gg: ASbGnctNehlZVjEsBFvjoy5M05GCuoWJmXB11PotDaf80o4z+QLoGV+KtNybAkJvNhe
	muMKTVNA8XGv5/mRr9EsLDkdO6l2ITnZzCZ+qzwRRCws+i3/PJoc2aOlMXL+FhmZkVl6tf/y4Uu
	SVxF6mCkxRx+c24S1mC1BYC9qKAUdDrx/w2W7iVecXmSwjYM6kTHMdaxsyEqGR+qQN0Jj4NYkYZ
	DfmDX3SY2NciGRVBlMoXrvtrpO15gZYKK7JbZe5MC9zswAaJaIDIxcehjTSBxsjgzrPY0kA3Lg6
	ibSaz6q2CeORjVBPRbJvWsR55UBDLuBDnvg2gereTtjuKNEK4B9FojlUCEJ15TbjT8/UbwDVorR
	nbzjb0C7X7eENQFu/9BpnycUzgeVqrbtRgg==
X-Google-Smtp-Source: AGHT+IFQVi/a8SANwVDb9RPthVJUL+WjymZG+8V9qSFj9TPWeGJvtY72FPEDrXoiH1amSPsIky8Axg==
X-Received: by 2002:a05:6214:2a83:b0:709:8749:927a with SMTP id 6a1803df08f44-709e8a0fa61mr4388496d6.50.1755027939577;
        Tue, 12 Aug 2025 12:45:39 -0700 (PDT)
Received: from rowland.harvard.edu ([2601:19b:681:fd10::e316])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7077cdf11b9sm182874386d6.74.2025.08.12.12.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Aug 2025 12:45:39 -0700 (PDT)
Date: Tue, 12 Aug 2025 15:45:35 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: gregkh@linuxfoundation.org
Cc: bentiss@kernel.org, stable@vger.kernel.org
Subject: [PATCH v2] HID: core: Harden s32ton() against conversion to 0 bits
Message-ID: <d7c6ee93-1e20-456d-84a3-832418af8dec@rowland.harvard.edu>
References: <2025081232-clear-humility-0629@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025081232-clear-humility-0629@gregkh>

Testing by the syzbot fuzzer showed that the HID core gets a
shift-out-of-bounds exception when it tries to convert a 32-bit
quantity to a 0-bit quantity.  Ideally this should never occur, but
there are buggy devices and some might have a report field with size
set to zero; we shouldn't reject the report or the device just because
of that.

Instead, harden the s32ton() routine so that it returns a reasonable
result instead of crashing when it is called with the number of bits
set to 0 -- the same as what snto32() does.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Reported-by: syzbot+b63d677d63bcac06cf90@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-usb/68753a08.050a0220.33d347.0008.GAE@google.com/
Fixes: dde5845a529f ("[PATCH] Generic HID layer - code split")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/613a66cd-4309-4bce-a4f7-2905f9bce0c9@rowland.harvard.edu

---

This is a version of the original patch, back-ported to 6.12 and before.  
The reason a different patch is required is because commit c653ffc28340 
("HID: stop exporting hid_snto32()") moved the s32ton() function to a 
different location in the file and added an extra blank line in the 
process.

I omitted the Test-by: tag from syzbot and the Signed-off-by: tag from 
Benjamin, as they don't strictly apply to this new version.

 hid-core.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

Index: usb-devel/drivers/hid/hid-core.c
===================================================================
--- usb-devel.orig/drivers/hid/hid-core.c
+++ usb-devel/drivers/hid/hid-core.c
@@ -1351,7 +1351,12 @@ EXPORT_SYMBOL_GPL(hid_snto32);
 
 static u32 s32ton(__s32 value, unsigned n)
 {
-	s32 a = value >> (n - 1);
+	s32 a;
+
+	if (!value || !n)
+		return 0;
+
+	a = value >> (n - 1);
 	if (a && a != -1)
 		return value < 0 ? 1 << (n - 1) : (1 << (n - 1)) - 1;
 	return value & ((1 << n) - 1);

