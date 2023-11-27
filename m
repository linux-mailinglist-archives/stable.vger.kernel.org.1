Return-Path: <stable+bounces-2780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E0F7FA76A
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 18:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AFA11C20B3C
	for <lists+stable@lfdr.de>; Mon, 27 Nov 2023 17:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79F2364D0;
	Mon, 27 Nov 2023 17:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIQ40ljq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65D1C30C6
	for <stable@vger.kernel.org>; Mon, 27 Nov 2023 09:00:30 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6cb749044a2so4420636b3a.0
        for <stable@vger.kernel.org>; Mon, 27 Nov 2023 09:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701104430; x=1701709230; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=8AgEC5hl9xTiJhztF4t3qyhaDyaWPbhPKGmUnOdojk8=;
        b=FIQ40ljqcC/CTQjsmwrJ/eB+2S89T3IvjSTic1e8OE2RfcY1DCs1up31Rhf/eTOVOy
         NXsrc57GibNEYEU765N20bMVo2/oi/E+l9F1MrbplpjR+Qzx/cLOglo2oaw6jZVTmx6o
         iS/yKZdxRh60EIqIa4kFq3n2VJ5Jxsc4gHgK80FFLqHgZwfHGONEtxlwYU6cdEGW1Szp
         YVsnzCJBZovVKBKWXmByE1/DCnC3mCBGZ9WPfhfZOT9ElHwn/FXI65/2E5r3/EBuo+t+
         gVynjT8nIJVrLkEl+dKlIJZm/zopenBHdBtCBc/Witsk2zeUYKkJACWGUOeFRy45MggA
         av5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701104430; x=1701709230;
        h=content-transfer-encoding:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AgEC5hl9xTiJhztF4t3qyhaDyaWPbhPKGmUnOdojk8=;
        b=KiUY7imZmn8/xWzodQGw9yWbbiJ1YWn3JPnlu1UrIj+PhlbITAcVn29ofKyexVE8No
         UDVxiaVnfc18Sr0pN01DG/2A0MMXkpjPNS0mDdGGVzKUvGDQmko/8tnN+CBTvXOyS3w8
         glNwj/pkmWJ9iQRJ6B7+auPBXqXRRtR4MKrlRDU2rNfc3axwPhkgKO985ocUbh0KHMJj
         cDyo1qF9vxSRyflbDTY8NdI4tW5fKnK9mNNuRb9qohT5zjhYifZhHWJxZ3dJdY4XO11X
         6OfftiPJvdcWOttS6O7DGY+XvaxJqLToPCHYg9Vf4R8pSYLIZ7GYUlshUgBrY8BXuxMt
         Li6A==
X-Gm-Message-State: AOJu0Yz1YZKEcUp81iuRPTH3VDa8HYz1MJor1vQeLJH61k0PGLcuMfQw
	acIqtVOD+DEiFqb+2mph/CxRMiFclXQ=
X-Google-Smtp-Source: AGHT+IETHh2i0TPF9neofLBdBVXeH6Pos4YVpkaq1g61Z+NROhs96zI+FJ55VhwLKuaLt2rbx+u4lQ==
X-Received: by 2002:a05:6a00:23cc:b0:6cd:8a19:c324 with SMTP id g12-20020a056a0023cc00b006cd8a19c324mr6223453pfc.3.1701104429710;
        Mon, 27 Nov 2023 09:00:29 -0800 (PST)
Received: from DESKTOP-6F6Q0LF (static-host119-30-85-97.link.net.pk. [119.30.85.97])
        by smtp.gmail.com with ESMTPSA id x10-20020aa7918a000000b0068c10187dc3sm7356165pfa.168.2023.11.27.09.00.27
        for <stable@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 27 Nov 2023 09:00:29 -0800 (PST)
Message-ID: <6564cb2d.a70a0220.cbbe4.1a41@mx.google.com>
Date: Mon, 27 Nov 2023 09:00:29 -0800 (PST)
X-Google-Original-Date: 27 Nov 2023 12:00:27 -0500
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: callahanbryson63@gmail.com
To: stable@vger.kernel.org
Subject: Building Estimates
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
X-Spam-Level: *

Hi,=0D=0A=0D=0AWe provide estimation & quantities takeoff service=
s. We are providing 98-100 accuracy in our estimates and take-off=
s. Please tell us if you need any estimating services regarding y=
our projects.=0D=0A=0D=0ASend over the plans and mention the exac=
t scope of work and shortly we will get back with a proposal on w=
hich our charges and turnaround time will be mentioned=0D=0A=0D=0A=
You may ask for sample estimates and take-offs. Thanks.=0D=0A=0D=0A=
Kind Regards=0D=0ACallahan Bryson		=0D=0ADreamland Estimation, LL=
C


