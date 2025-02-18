Return-Path: <stable+bounces-116820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E66A3A820
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 20:55:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7774174DF0
	for <lists+stable@lfdr.de>; Tue, 18 Feb 2025 19:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEBA1EFFAE;
	Tue, 18 Feb 2025 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k+YbI5Uc"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B673C1F;
	Tue, 18 Feb 2025 19:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908406; cv=none; b=OgVQt1VBs10Cn7iKk2/CC8alSG/J96eIO+NqOpF9xGhUgGpwZu9YLsz5Y85QxtquIZY22fbWxWhKsSgvrdmf/B7QErIytwhyQcysECeNxERe2Y9SwSa726uCytXAzpZBtqU0ItU+B5TDD3xFUhFZ6G+XdzLUH0ouFQC5b19FMUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908406; c=relaxed/simple;
	bh=oUddVi/aa0SrzO0CKv63fLA+1S1fixsrcxfBr/kf6Nk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RluWrJhRONwRCIb8xHyhbrn1Y5aIZlezZeAcv2gVtuQ2WUVbTYEPyJfR87BiYzM5eJNJOFyw/OBxaF2r5OMVsB0tv/FnzlhWQetE3v99Oh+ZtI+ftjLIeXzYav7hE6V0ObhYOB2vdJQM0nJyiJLoJdv+OVrAxVyesCaMQqZYdm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k+YbI5Uc; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30613802a6bso61380041fa.1;
        Tue, 18 Feb 2025 11:53:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739908402; x=1740513202; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pGDbkWE6fakecVfFZmZx9iEUYbcFt3f4fh1ehQDA1do=;
        b=k+YbI5UcshSOW6m2spKdaXhypWTYnnvrgAqOr8NGkkcFpbZB6+LqDkEpV4ExX0yjvL
         fUrPqbMXx4RuT4uHKGH2GPTZksfuN0zRCeHa20oBmALHqwUtcR3DfFwbEHMyXYIN5kS+
         NCM2/6e3IdTo6hHv3nyTh/xCSRbyusYAaAa9EkSgA2KxlRR6boU9LW2Z7KfyA6Han/Ub
         X+ZVAdSCIEuTcSKmFw1pkI6MS0nwF/IICwou1S5g3SKUjXfNVboDBx7OfimgCrnnVGa3
         rQDffuUp4fPdKaVKv3p+r4A6HI0Cc+nmh0JdSYXXL3VSFfJEpUPTD7MSc648iEu0rHeC
         kHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739908402; x=1740513202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pGDbkWE6fakecVfFZmZx9iEUYbcFt3f4fh1ehQDA1do=;
        b=jGSY7WqNsBlpqZcoPDD46Q640UODo9KYwVlK4q2hFHkFuLjQhCYj0fTPh5r2X2HRJB
         /dq4+4myvATCpyPUsvfcqnP9sJkz+ydA5IncPmRFlZJTwSzvQargREIvd/4pvCICKCgL
         1MvqyIqxs8IxXTNnHB8DbCDWTHy7QTgzXJ6pQykbLudWX7f5r0qs0kSNYbysb+7Y9vf1
         6TzVNIDlFr+pvkzl22AQ24mOq81jJ+E2Vlj6oCzXgTBmJJAvU1eBbhwr9bEz+yG4disl
         CyXM++9qATDa0DfB1jHmSqlhyBuoEgthzbYfONf8ETN4JTUE6T9tE27Nua5Bi4PtfE2W
         4XAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1M9C6MmPJ4mL7zurPQVr6F6Pwk8pScxsliA+5UZalbS8748R+/KkzSsWVRcBZsC4TDxy7t3AJkiPc@vger.kernel.org, AJvYcCU7DfbQLJuvQB9PwKwIjvX0fzr9Cwu0akZvOMmZIqBzJFvyjUipil5rZqFuazd//faG+DWxqmbO@vger.kernel.org, AJvYcCXkfFx5JSvZ7a1kK+YxCZNh4Cb5vJhwlZlIRJdVRugbSMvjlVvX3Tll4B1gYHzYNblTcpzZr9ZgYjxH+Ro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHZrKWM+gJ3e7dblskEnCo3FNG+a2ymi+u9mUqhUS+VPB0eMqD
	2XXN3gMufFAAn6RHGdyT7MVhcQ7VoYjP56iRidMPmgQ9AZ6SacH4
X-Gm-Gg: ASbGncv5+L5tWI/xZPDpugV/Vl0Om9rdvtD0bSeXbmR502mQDZJjCy6tglmWmV5mGqR
	Wiz7htZv4uIASjRseopx/BUTF/u2aF00Q3C2HpCZF9sJhRr0DzdUAZBh6LCTlDTmlc00qLZ72db
	5PRNL9eDgEJphB8u9JyV8KWWJQ0INOMjMxSbQr0aJj5M+zofwSlKq2CXjFzRrYtZH+ImJdfIPgn
	JRC+T5bEjVBsQvM/XhOVd051HD8CUtHyjqRDkISh6xTLqz7hYwsS/QHkS7DHGoMgIieaK4HTmEf
	8dFhaLPwsJFY1eC1lRyoUk0h
X-Google-Smtp-Source: AGHT+IGZ//zV/5EN5eTZO456ecLPWEjG98vfM3ecYixQDV/23ROfXJKT4Q3ZMPU8nl5R/rk4LtP3dg==
X-Received: by 2002:a2e:9ed5:0:b0:304:68e5:eabd with SMTP id 38308e7fff4ca-30927a2cdd9mr39028821fa.3.1739908401796;
        Tue, 18 Feb 2025 11:53:21 -0800 (PST)
Received: from localhost (morra.ispras.ru. [83.149.199.253])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-309302c7477sm13466141fa.85.2025.02.18.11.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 11:53:21 -0800 (PST)
Date: Tue, 18 Feb 2025 22:53:20 +0300
From: Fedor Pchelkin <boddah8794@gmail.com>
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	"Christian A. Ehrhardt" <lk@c--e.de>, Greg KH <gregkh@linuxfoundation.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Benson Leung <bleung@chromium.org>, 
	Jameson Thies <jthies@google.com>, Saranya Gopal <saranya.gopal@intel.com>, 
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RFC 2/2] usb: typec: ucsi: increase timeout for PPM reset
 operations
Message-ID: <7uspvfyqgld7jecbytouocpnqbspegthcx2py2grnvi3r6f3b4@pgzjowheyvig>
References: <20250206184327.16308-1-boddah8794@gmail.com>
 <20250206184327.16308-3-boddah8794@gmail.com>
 <c48d6d73-73d6-4df6-8e9c-c8f2ecdd654a@app.fastmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c48d6d73-73d6-4df6-8e9c-c8f2ecdd654a@app.fastmail.com>

On Tue, 18. Feb 11:57, Mark Pearson wrote:
> Hi  Fedor,
> 
> On Thu, Feb 6, 2025, at 1:43 PM, Fedor Pchelkin wrote:
> > It is observed that on some systems an initial PPM reset during the boot
> > phase can trigger a timeout:
> >
> > [    6.482546] ucsi_acpi USBC000:00: failed to reset PPM!
> > [    6.482551] ucsi_acpi USBC000:00: error -ETIMEDOUT: PPM init failed
> >
> > Still, increasing the timeout value, albeit being the most straightforward
> > solution, eliminates the problem: the initial PPM reset may take up to
> > ~8000-10000ms on some Lenovo laptops. When it is reset after the above
> > period of time (or even if ucsi_reset_ppm() is not called overall), UCSI
> > works as expected.
> >
> > Moreover, if the ucsi_acpi module is loaded/unloaded manually after the
> > system has booted, reading the CCI values and resetting the PPM works
> > perfectly, without any timeout. Thus it's only a boot-time issue.
> >
> > The reason for this behavior is not clear but it may be the consequence
> > of some tricks that the firmware performs or be an actual firmware bug.
> > As a workaround, increase the timeout to avoid failing the UCSI
> > initialization prematurely.
> >
> 
> Could you let me know which Lenovo platform(s) you see the issue on?
> 
> I don't have any concerns with the patch below, but if the platform is in
> the Linux program I can reach out to the FW team and try to determine if
> there's an expected time needed (and how close we are to it).

Yep, here. (also at the bottom of the [PATCH RFC 0/2] mail)

Please let me know if there's more info needed.

Machine:
  Type: Laptop System: LENOVO product: 21D0 v: ThinkBook 14 G4+ ARA
    serial: <superuser required>
  Mobo: LENOVO model: LNVNB161216 v: SDK0T76479 WIN
    serial: <superuser required> UEFI: LENOVO v: J6CN50WW date: 09/27/2024


Relevant part of the ACPI dump.

    Scope (\_SB)
    {
        Device (UBTC)
        {
            Name (_HID, EisaId ("USBC000"))  // _HID: Hardware ID
            Name (_CID, EisaId ("PNP0CA0"))  // _CID: Compatible ID
            Name (_UID, Zero)  // _UID: Unique ID
            Name (_DDN, "USB Type C")  // _DDN: DOS Device Name
            Name (_ADR, Zero)  // _ADR: Address
            Name (_DEP, Package (0x01)  // _DEP: Dependencies
            {
                \_SB.PCI0.LPC0.EC0
            })
            Method (_STA, 0, NotSerialized)  // _STA: Status
            {
                Return (0x0F)
            }

            Method (_PS0, 0, Serialized)  // _PS0: Power State 0
            {
                Sleep (0x07D0)
            }

            Method (_PS3, 0, Serialized)  // _PS3: Power State 3
            {
                Sleep (0x07D0)
            }

            Method (TPLD, 2, Serialized)
            {
                Name (PCKG, Package (0x01)
                {
                    Buffer (0x10){}
                })
                CreateField (DerefOf (PCKG [Zero]), Zero, 0x07, REV)
                REV = One
                CreateField (DerefOf (PCKG [Zero]), 0x40, One, VISI)
                VISI = Arg0
                CreateField (DerefOf (PCKG [Zero]), 0x57, 0x08, GPOS)
                GPOS = Arg1
                CreateField (DerefOf (PCKG [Zero]), 0x4A, 0x04, SHAP)
                SHAP = One
                CreateField (DerefOf (PCKG [Zero]), 0x20, 0x10, WID)
                WID = 0x08
                CreateField (DerefOf (PCKG [Zero]), 0x30, 0x10, HGT)
                HGT = 0x03
                Return (PCKG) /* \_SB_.UBTC.TPLD.PCKG */
            }

            Method (_CRS, 0, NotSerialized)  // _CRS: Current Resource Settings
            {
                Name (RBUF, ResourceTemplate ()
                {
                    Memory32Fixed (ReadWrite,
                        0x7AF66000,         // Address Base
                        0x00001000,         // Address Length
                        )
                })
                Return (RBUF) /* \_SB_.UBTC._CRS.RBUF */
            }

            Device (HSP1)
            {
                Name (_ADR, One)  // _ADR: Address
                Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                {
                    0xFF, 
                    0x09, 
                    Zero, 
                    Zero
                })
                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    Return (TPLD (One, 0x04))
                }
            }

            Device (HSP2)
            {
                Name (_ADR, One)  // _ADR: Address
                Name (_UPC, Package (0x04)  // _UPC: USB Port Capabilities
                {
                    0xFF, 
                    0x09, 
                    Zero, 
                    Zero
                })
                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    Return (TPLD (One, 0x04))
                }
            }

            OperationRegion (USBC, SystemMemory, 0x7AF66000, 0x30)
            Field (USBC, ByteAcc, Lock, Preserve)
            {
                VER1,   8, 
                VER2,   8, 
                RSV1,   8, 
                RSV2,   8, 
                CCI0,   8, 
                CCI1,   8, 
                CCI2,   8, 
                CCI3,   8, 
                CTL0,   8, 
                CTL1,   8, 
                CTL2,   8, 
                CTL3,   8, 
                CTL4,   8, 
                CTL5,   8, 
                CTL6,   8, 
                CTL7,   8, 
                MGI0,   8, 
                MGI1,   8, 
                MGI2,   8, 
                MGI3,   8, 
                MGI4,   8, 
                MGI5,   8, 
                MGI6,   8, 
                MGI7,   8, 
                MGI8,   8, 
                MGI9,   8, 
                MGIA,   8, 
                MGIB,   8, 
                MGIC,   8, 
                MGID,   8, 
                MGIE,   8, 
                MGIF,   8, 
                MGO0,   8, 
                MGO1,   8, 
                MGO2,   8, 
                MGO3,   8, 
                MGO4,   8, 
                MGO5,   8, 
                MGO6,   8, 
                MGO7,   8, 
                MGO8,   8, 
                MGO9,   8, 
                MGOA,   8, 
                MGOB,   8, 
                MGOC,   8, 
                MGOD,   8, 
                MGOE,   8, 
                MGOF,   8
            }

            OperationRegion (DBG0, SystemIO, 0x80, One)
            Field (DBG0, ByteAcc, NoLock, Preserve)
            {
                IO80,   8
            }

            Method (NTFY, 0, Serialized)
            {
                ECRD ()
                Sleep (One)
                Notify (\_SB.UBTC, 0x80) // Status Change
            }

            Method (ECWR, 0, Serialized)
            {
                IO80 = 0xA0
                \_SB.PCI0.LPC0.EC0.ECWT (MGO0, RefOf (\_SB.PCI0.LPC0.EC0.MGO0))
                \_SB.PCI0.LPC0.EC0.ECWT (MGO1, RefOf (\_SB.PCI0.LPC0.EC0.MGO1))
                \_SB.PCI0.LPC0.EC0.ECWT (MGO2, RefOf (\_SB.PCI0.LPC0.EC0.MGO2))
                \_SB.PCI0.LPC0.EC0.ECWT (MGO3, RefOf (\_SB.PCI0.LPC0.EC0.MGO3))
                \_SB.PCI0.LPC0.EC0.ECWT (MGO4, RefOf (\_SB.PCI0.LPC0.EC0.MGO4))
                \_SB.PCI0.LPC0.EC0.ECWT (MGO5, RefOf (\_SB.PCI0.LPC0.EC0.MGO5))
                \_SB.PCI0.LPC0.EC0.ECWT (MGO6, RefOf (\_SB.PCI0.LPC0.EC0.MGO6))
                \_SB.PCI0.LPC0.EC0.ECWT (MGO7, RefOf (\_SB.PCI0.LPC0.EC0.MGO7))
                \_SB.PCI0.LPC0.EC0.ECWT (MGO8, RefOf (\_SB.PCI0.LPC0.EC0.MGO8))
                \_SB.PCI0.LPC0.EC0.ECWT (MGO9, RefOf (\_SB.PCI0.LPC0.EC0.MGO9))
                \_SB.PCI0.LPC0.EC0.ECWT (MGOA, RefOf (\_SB.PCI0.LPC0.EC0.MGOA))
                \_SB.PCI0.LPC0.EC0.ECWT (MGOB, RefOf (\_SB.PCI0.LPC0.EC0.MGOB))
                \_SB.PCI0.LPC0.EC0.ECWT (MGOC, RefOf (\_SB.PCI0.LPC0.EC0.MGOC))
                \_SB.PCI0.LPC0.EC0.ECWT (MGOD, RefOf (\_SB.PCI0.LPC0.EC0.MGOD))
                \_SB.PCI0.LPC0.EC0.ECWT (MGOE, RefOf (\_SB.PCI0.LPC0.EC0.MGOE))
                \_SB.PCI0.LPC0.EC0.ECWT (MGOF, RefOf (\_SB.PCI0.LPC0.EC0.MGOF))
                \_SB.PCI0.LPC0.EC0.ECWT (CTL0, RefOf (\_SB.PCI0.LPC0.EC0.CTL0))
                \_SB.PCI0.LPC0.EC0.ECWT (CTL1, RefOf (\_SB.PCI0.LPC0.EC0.CTL1))
                \_SB.PCI0.LPC0.EC0.ECWT (CTL2, RefOf (\_SB.PCI0.LPC0.EC0.CTL2))
                \_SB.PCI0.LPC0.EC0.ECWT (CTL3, RefOf (\_SB.PCI0.LPC0.EC0.CTL3))
                \_SB.PCI0.LPC0.EC0.ECWT (CTL4, RefOf (\_SB.PCI0.LPC0.EC0.CTL4))
                \_SB.PCI0.LPC0.EC0.ECWT (CTL5, RefOf (\_SB.PCI0.LPC0.EC0.CTL5))
                \_SB.PCI0.LPC0.EC0.ECWT (CTL6, RefOf (\_SB.PCI0.LPC0.EC0.CTL6))
                \_SB.PCI0.LPC0.EC0.ECWT (CTL7, RefOf (\_SB.PCI0.LPC0.EC0.CTL7))
                \_SB.PCI0.LPC0.EC0.ECWT (0xE0, RefOf (\_SB.PCI0.LPC0.EC0.USDC))
                IO80 = 0xA1
            }

            Method (ECRD, 0, Serialized)
            {
                IO80 = 0xA3
                MGI0 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.MGI0))
                MGI1 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.MGI1))
                MGI2 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.MGI2))
                MGI3 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.MGI3))
                MGI4 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.MGI4))
                MGI5 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.MGI5))
                MGI6 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.MGI6))
                MGI7 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.MGI7))
                MGI8 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.MGI8))
                MGI9 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.MGI9))
                MGIA = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.MGIA))
                MGIB = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.MGIB))
                MGIC = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.MGIC))
                MGID = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.MGID))
                MGIE = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.MGIE))
                MGIF = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.MGIF))
                VER1 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.VER1))
                VER2 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.VER2))
                RSV1 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.RSV1))
                RSV2 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.RSV2))
                CCI0 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.CCI0))
                CCI1 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.CCI1))
                CCI2 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.CCI2))
                CCI3 = \_SB.PCI0.LPC0.EC0.ECRD (RefOf (\_SB.PCI0.LPC0.EC0.CCI3))
                \_SB.PCI0.LPC0.EC0.ECWT (0xE1, RefOf (\_SB.PCI0.LPC0.EC0.USGC))
                IO80 = 0xA4
            }

            Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
            {
                If ((Arg0 == ToUUID ("6f8398c2-7ca4-11e4-ad36-631042b5008f") /* Unknown UUID */))
                {
                    If ((ToInteger (Arg2) == Zero))
                    {
                        Return (Buffer (One)
                        {
                             0x0F                                             // .
                        })
                    }
                    ElseIf ((ToInteger (Arg2) == One))
                    {
                        ECWR ()
                    }
                    ElseIf ((ToInteger (Arg2) == 0x02))
                    {
                        ECRD ()
                    }
                    Else
                    {
                        Return (Zero)
                    }
                }

                Return (Zero)
            }
        }
    }

