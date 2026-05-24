Return-Path: <stable+bounces-253999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5FxRLtmaEmoG1gYAu9opvQ
	(envelope-from <stable+bounces-253999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 08:29:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1784C5C184B
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 08:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6037630117BA
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 06:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C5F38E8A1;
	Sun, 24 May 2026 06:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hqc5GQ4U"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5781221CFE0
	for <stable@vger.kernel.org>; Sun, 24 May 2026 06:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779604180; cv=pass; b=fgZJqYWo4lnegvTr2fMZlsODTZOaSICViQnOmwLV/5w/ngm5fJ/s6D80mTbFd8mvzayFOSSBxbIYws7l+Y965F6h46FiQJWs6EeIBHfl7q23WQ+V5GGGted2RwW3KYyzcinSTN7qLDovQFrGW7QMgTfM1pziSy4fFACV4tykTIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779604180; c=relaxed/simple;
	bh=X6EaY0Ai1amObm64brt2FocCiJyv1z8T5Qwej2XOZZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZiU2BXpPZGHzI7AO4dqtPsV9D+UnCM2nKc02ixp+uBUMvDPJ3AjNG8ExQI836/qN1EQkdyZFGpK6AdMTQq3MX4crCGjIx6zxVVf3e4kNAxYsr1dyWs/s2lHKs6Z+bsAvrzFaK4I+/cZCadnKSFl56xg78UdBIq3CU3DvLv4qdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hqc5GQ4U; arc=pass smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-651c5d525f6so8632531d50.3
        for <stable@vger.kernel.org>; Sat, 23 May 2026 23:29:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779604177; cv=none;
        d=google.com; s=arc-20240605;
        b=FtgqWT7TlvqtcFnQfRAceChasY0X88GuFr/QvjpF5wJuQH2oxlgHAzH3ikvnSNymSb
         ecnH4DjKjFc2hU8S1A5bAeJYYOPnMmLBCtRX8V1B/psqG6NZRgfolTBLlAugoFBdnvrU
         mDscrSblTBblIF+ep/nvAaA9wiEA2Rdr8aOgoZ/56eKN/XC5q2Y/Mq9uIBYbqWrD+E7H
         peCi7JU0qZmXBSQOFg5aowJRuvOA/AJL9uXth4/4o63/IO/2gOzAOXfwIorkm6NLH+km
         BTu5G46LURuxyy470L8EXBRzSPT+2Bi8MUV3cDOwQSxNOaFQuZPy1W7skykANeK72beA
         Oy4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=zYnV1rCuWZnxSIwwypty56meo5dLmcFPMrkTKYeaGD8=;
        fh=4RkcWtJFqeh+VBai22E09g1Ix2uSo0S0fKUPqfG3wxY=;
        b=c1ste/U4m5Lrcq6+EsUH7XFoOEw6FpKjhJDuRkz57nG6XUjG0Gqb5cyHSCPQPpoJRv
         LwvWsgSdOrIIRmIRL+WsIWKlCz0pE0eOhDQrHMMTiJ3zoJsq1S0ocWTYM0qMM0tCeJ/O
         TcDKRwQaUCbx809xi3piK/ENfLRRrUrGdrHZnFlUXXsg9DNZtmNNFN0TdbajxbSc3pub
         ZdijhnBPNdZ7hD0jeiU7y+20aFyv4Eoe7DJJFSCnPoTHToUTQMlRfGjJzhiD8xloEtHa
         +3mwBPE1U0y08DpHycKlGm7y9IeI0bcr1IJPMnts6A0MmhmhjT/eU+BgAatURO2XfDyr
         Z3ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779604177; x=1780208977; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zYnV1rCuWZnxSIwwypty56meo5dLmcFPMrkTKYeaGD8=;
        b=Hqc5GQ4UdsmNAxZFDgVvTyRUehsRGXJPTSamRwmM+En41e3jm5EmjBAdC1QewhwYLj
         JyaL2Vo2kBM8nbluUYM9ytYCPfZC6OiXzT2GEUO0qlW7NFB8f7iRCJoIFtTQ20LsHKw7
         PslAVJQ6CuC9u3ZFCpWBtypB4ZY2uYcqaPAt+URuW2N3mt/LpXiv6JtkiWrudCPFDoMa
         3fw7k9NO7UYJEYpxHY7OizSw+we6VZIQ3WUbLr5GLEWAvsWN4x7zWsW+F8zT+GWO8kDJ
         R7RMVOCjwd7fTuvaI2mWR8CZIvA2SSZW7yWvo4Lvsbc6sR9HS3otpg8VNhDsYhhi7ooC
         o5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779604177; x=1780208977;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zYnV1rCuWZnxSIwwypty56meo5dLmcFPMrkTKYeaGD8=;
        b=PHE87W1yfZDyk2NLeQvNpyQIc+kNADsh2a2VDuAyMit7AL+syU0pA/WEwMGrZad7Fm
         nKdzMTe35hS16acMX0rbFfhZuFkoi0pwi3qipBPgXhDFCa/TdTCzIUi8C/4Pj+EwKNCh
         VKS1+yHKsCtN1c9buBrIgtXDxxQ/9SbS1yl18z9zo+MuUjBfrXc/ii8qsCUh6c7qGQun
         w1Ag/WEz/bfTshQNljLs/Bnr5qY++WaTywuS7OlUu6g/yK0UIqB3sC/3/FHRkMV6+XpW
         HcGoVpHF/LOfCZ74rY6vl6ZVAD7QZAT8cRYjY5dnj8HEsJfeTJPo8rvkodU69yI13UZq
         V7Yw==
X-Forwarded-Encrypted: i=1; AFNElJ9GfBw20Ynp7tOqvlUNky3RNoWMQkTUTF4cRa05w+gJco96Iz6m0EgfJqVE0cJ/qr/65Qto0XQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/etiirZrODXxMd6qnIQb/PmgQGq4DOoFu5LcTI8IpYVc9vySc
	KqDB+ZQIzWhBrCUDEl9RNHiDiMzSQDkhLMt7ZjG9Qui8nvdanJva6UmzehzbqA+j7kikghx/eOU
	oHahEp+1PQs3SxhTSBoS2+KwTlt2QboGN8HlAFCU=
X-Gm-Gg: Acq92OGta6v9O7Ntfs2Ct1JSPnHRWZ3MlyCkitiXbRD3h9P8RaxPksnipRH4glCDcL1
	PKGyxATkOswPaptZ0GSkS9cVlYT0+vV+spP7m53HyLzn45p4TOPa5LjjP8b/xdutfrYqgaXpFD1
	fPodY3qv1pjgTNzAw/lLGjMT/7DhC1tJSipq6Ol92ZKQeIhUGzW4e0pex/tGq/YnoFb+I89sYU1
	eErhAJ5o9vX0aaFBcogFtI/irQUk1e1ll1TVx0kG4faSe/BknkriSZqRB1KbBoaejfAyhOV0HBW
	ZG/GqSI=
X-Received: by 2002:a05:690e:428f:10b0:65e:449f:4e24 with SMTP id
 956f58d0204a3-65ec995d019mr7631677d50.47.1779604177366; Sat, 23 May 2026
 23:29:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416155443.3949056-1-lgs201920130244@gmail.com> <2026052229-overspend-preoccupy-2f6f@gregkh>
In-Reply-To: <2026052229-overspend-preoccupy-2f6f@gregkh>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sun, 24 May 2026 14:29:20 +0800
X-Gm-Features: AVHnY4LwLl0ihbKIcHQM_fG7TsEG_idydNLp0GGjOg47Od3AjoJqLEIIgg8jW3M
Message-ID: <CANUHTR-AGDfWgiLpqRWsBvxH=kPgxf+rD+gTOxA12yLmDrupNg@mail.gmail.com>
Subject: Re: [PATCH] uio: fix IRQ vector leak on probe failure and remove
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Yaxing Guo <guoyaxing@bosc.ac.cn>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253999-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1784C5C184B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

Thank you for reviewing the patch.

On Fri, 22 May 2026 at 18:03, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Thu, Apr 16, 2026 at 11:54:43PM +0800, Guangshuo Li wrote:
> > probe() allocates MSI/MSI-X vectors with pci_alloc_irq_vectors(), but
> > neither the error path nor remove() releases them with
> > pci_free_irq_vectors().
> >
> > Unlike drivers using pcim_enable_device(), this driver uses
> > pci_enable_device(), so the IRQ vectors are not managed automatically
> > and must be freed explicitly.
> >
> > Add pci_free_irq_vectors() to the probe error path after successful
> > vector allocation and to remove(). The issue was identified by a
> > static analysis tool I developed.
> >
> > Fixes: 3397c3cd859a ("uio: Add SVA support for PCI devices via uio_pci_generic_sva.c")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> > ---
> >  drivers/uio/uio_pci_generic_sva.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/uio/uio_pci_generic_sva.c b/drivers/uio/uio_pci_generic_sva.c
> > index 4a46acd994a8..ea531f9a164c 100644
> > --- a/drivers/uio/uio_pci_generic_sva.c
> > +++ b/drivers/uio/uio_pci_generic_sva.c
> > @@ -62,7 +62,7 @@ static int uio_pci_sva_release(struct uio_info *info, struct inode *inode)
> >  static int probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  {
> >       struct uio_pci_sva_dev *udev;
> > -     int ret, i, irq = 0;
> > +     int ret, i, irq = 0, have_irq_vectors = 0;
>
> have_irq_vectors should be a bool.

I will change have_irq_vectors to a bool and send a v2.

Best regards,
Guangshuo

