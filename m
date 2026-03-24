Return-Path: <stable+bounces-230226-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AG1hE4ztwmkdnQQAu9opvQ
	(envelope-from <stable+bounces-230226-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 21:01:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB6A31C03D
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 21:01:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AA1E3074A13
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 20:00:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B48F2C15B5;
	Tue, 24 Mar 2026 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F7mtgBtR"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3E24676D
	for <stable@vger.kernel.org>; Tue, 24 Mar 2026 20:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774382434; cv=pass; b=Va1+cjS0uVM2jRemJmT8wFO0ov347hiTanEq2t5prm0js45NIidl+r3bUNGDY4YDLA6F+2DseMqJiN/Ex/ovwQ2fRPRBQLtQ4xtP3ADiMqH59BU/SJqzC3cZ6bYHbJtRmBbeGZsWYmtpQG6zOBSQl3xonx/2diFRgHJY1mLqgwQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774382434; c=relaxed/simple;
	bh=H/3/HljBKkNQvfAF2nYLo4pPn7IMLelTewsSEwuiXqA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dlb+UbXLUilXIi3ZvzqDSI77pC63O1RoeTDOYjH2IKBosO5mJp9G8ybLUBwaSr1skFa3RkEwshUn351g2PK3xK6/WBfSTGCLue4K92uwy7Gmc+5oV0P4+tBl3G0YpThhBixb1dT35TdHy/fZt1uLjP3SuZ2Z4TZj2zFFB6JWc18=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F7mtgBtR; arc=pass smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6618bc129acso2414741a12.2
        for <stable@vger.kernel.org>; Tue, 24 Mar 2026 13:00:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774382431; cv=none;
        d=google.com; s=arc-20240605;
        b=Q1ADb7opo8eEE+gLHTq4vlBs9a+XOeb8kzkhX/IN6n7XzkgSYq65QZOUzJRbnWnSEE
         n23Q8hKWiDiXEx/2425oqauKey82+OuBcA1PB6nM5+5gfWCZ7maoJ2HcrvzmvePH9iaU
         tCqwrtkR5nx2lr2MSn+DORoHaM+hk69LG3K3Y+Jf5Se14g7AvYKmXCL1xaLpyVzIBRBf
         g3VOanl0rzYHOMU4pPX4WTMQ0hMaxkP37QpjmfXsa9AkfwtRXdv9ZrVauwdzCYk7TXJd
         +vilHrQ9+9iVEUhWgRhc5s0nWa1QDa0lEXneBycK2s/ZNEk5kyp/ARPdlQaJv5mpZrzL
         mkww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1nuigy5i6MlCzZ5OS0a7Db3vipXMg/2DN1anL0e9s4w=;
        fh=UBchOitgO9+W3yw9Ai4fCqIFZA6WG9OC05HCBIL/S84=;
        b=Vg9mbY7qfte3L1YY8qRjxDC+4nwwDm7PA/PSUwiBOYw4E7DRYK84XO/vfMzW0hP71t
         Blt7d8bHj+s24Rdc817YxHmedWDz1pqZqJuceun13EPMryMz7Qo29kvav4i+dprA+lFM
         FxYIzQPrSyNdEnft3FV/nCLzdArhepKAEhmn3w4DO0pdr8qFY4ddJUtNZBrvMi4ktC07
         gqXagEr1m3O2CNziBsB+5ar40Roho77Z1DlDtUmCWjvcMcsbdPnC55FbrdgIgbq5WNcO
         WXw92LwlivsIYdBFR42ascDjxEdz+T24oxNVW+pDym+jIaaCt2Ghy+ZdAad/+jiR8xeW
         UYLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774382431; x=1774987231; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1nuigy5i6MlCzZ5OS0a7Db3vipXMg/2DN1anL0e9s4w=;
        b=F7mtgBtRyRp+eUyW0oozsSHJAmc87CmiVVOlDMGik0btrZGo5RYmJmYgRT96t2z4Z0
         nsrFs9OpzCJIGsa781SDRlkGBbsYJqmGG97BglLgX61JkLrPRiD3SfBwjtB0YVa7iG+9
         6BYQAdAtt5l1GPtIhdFwwhxzq0/HecEKOW02Wqa7Ri8HmEvzRj/ScQAhuUAagwjHmXmc
         /RJYmPkOxHygfmmfKQxW83CzScLwt2/udvyzth7Sh5HsjFF8k0KmUSD9CO2SC+u2BvA9
         B0VEhihjRnX36imrSDFJLI8UV4rEG+PCUgEvq8z/skQhTZi3D2fphLhf/K83K6MJ8/Kz
         Ffcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774382431; x=1774987231;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1nuigy5i6MlCzZ5OS0a7Db3vipXMg/2DN1anL0e9s4w=;
        b=HmyVYYHM8rcJPD6M/Jcnf7sGVkZWD77q3hDC2yeuG4o1ORGCDYHfjxb8TodJvTMiF9
         75yiD/Nk8fJXrPCrK6cQyoV+ACC4nh44JJVGNIjgs271nmqx2Ufy5S1XvVc5CK2E0ofI
         l+PXFv8RfC1m518mG2GxfhF4uLYNL3gvajbHb0dtr1kBLS0uwig2HazNuZWr516VEPir
         tPugCFDTwNj1awN32+jUL77dIjP+DP2Yab0dtdPuIbsDB8IVSRtAV3GwXkOpaNiwQbe4
         QKlWIYripZ8YpGpQ/tklgKbCdbpsVVXhxqZiFBtRwi5t8GTHdJoV4BWB+0rMVXwfiWxP
         XjIw==
X-Forwarded-Encrypted: i=1; AJvYcCX1Qh1tsfa3Hs0I7nO6eCtNPWaSxWezLFj5nP5aSV26delgeSrt4eb+wjUJyKvEiSHL0wZ2e/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP+LC5CnwwGwwJvj56jS0HqFXczwZIqE/0lSuNajtuKYEwI8JU
	AcZMSXk89S2JEEzcZBwsTh7PjFk3TsHMN46VkKl190Dgo+QZvBoJddthTb9t5o992iOwH0V8u7J
	kUbD0Iay67iTu48hFNC1mdevie704Hyc=
X-Gm-Gg: ATEYQzx6+AoK0hsnuI3sCWFnOOjA52bFZVv9jOncaWiJhHARNMaI1w6YoZO+aEBMosB
	EgytC6QTXlCfFJqzOWRrU3R/8Y/qHmAYG+aw56VOTYV3Cqv4b8aY9lEqPLMbdfIgdjChxaLQm6y
	wNFBBnjEog/CPDdv1Hj8LIdPydBSoHMiB0YKAmaiTXSkL2qIOEvFUpYF2Gh4NmzUL5gD0B+2QLd
	6iK+km0WX5ABGcWgFWAtZhKblPadWo8mEn8zYzd/zYq72c2Ap6QFYRDQh+ZXL+FS6Kwbr7nlYhD
	dodNOLk=
X-Received: by 2002:a17:907:1999:b0:b97:89b5:d7a0 with SMTP id
 a640c23a62f3a-b9a54288647mr44602266b.48.1774382431128; Tue, 24 Mar 2026
 13:00:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324173527.11321-1-sebasjosue84@gmail.com>
In-Reply-To: <20260324173527.11321-1-sebasjosue84@gmail.com>
From: Michael Zaidman <michael.zaidman@gmail.com>
Date: Tue, 24 Mar 2026 22:00:20 +0200
X-Gm-Features: AQROBzD7DJFoR-w2ZbaKS2onxXaNipjwmPIQropG4PSX5rpIV2agbqhUt5sEkcM
Message-ID: <CAPnwWgOY6UO2JKMNWw_fZK3Vvg_v9zQWX6Ugz=X+b4esPTn7Rg@mail.gmail.com>
Subject: Re: [PATCH] HID: ft260: validate report size in raw_event handler
To: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
Cc: jikos@kernel.org, bentiss@kernel.org, linux-i2c@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230226-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelzaidman@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: BDB6A31C03D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Sebastian,

Thanks for the patch. The report size validation gap in ft260_raw_event()
is a valid concern - the raw_event callback is indeed invoked before
hid_report_raw_event() validates the report size, so a truncated report
from a malicious or buggy device could cause OOB reads.

However, I have a couple of comments on the proposed fix:

Please use the existing FT260_REPORT_MAX_LENGTH macro instead of the
hardcoded 64.

More importantly, the size < 64 check alone is insufficient. It prevents
accessing struct fields in a truncated buffer, but does not guard against
a corrupted xfer->length field in an otherwise full-sized report.

Consider: a device sends a valid 64-byte report (passes the size check),
but with xfer->length set to, say, 100. The data payload starts at offset 2=
,
so only 62 bytes are available in the buffer. The existing check at line 10=
77
validates against the destination buffer (dev->read_len - dev->read_idx),
not the source. If read_len is large enough (e.g., 180), the check passes,
and the memcpy reads 100 bytes from a 62-byte region - a 38-byte OOB heap
read from the source side.

A more complete fix would validate xfer->length against the actual report s=
ize:

    struct ft260_i2c_input_report *xfer =3D (void *)data;
    if (size < FT260_REPORT_MAX_LENGTH) {
        hid_warn(hdev, "short report: %d\n", size);
        return 0;
    }
    if (xfer->length > size -
        offsetof(struct ft260_i2c_input_report, data)) {
        hid_warn(hdev, "payload %d exceeds report size %d\n",
             xfer->length, size);
        return 0;
    }
This catches both truncated reports and corrupted length fields.

Would you like to send a v2 addressing the above?

Thanks, Michael

On Tue, Mar 24, 2026 at 7:35=E2=80=AFPM Sebastian Josue Alba Vives
<sebasjosue84@gmail.com> wrote:
>
> ft260_raw_event() casts the raw data buffer to a
> ft260_i2c_input_report struct and accesses its fields without
> validating the size parameter. Since __hid_input_report() invokes
> the driver's raw_event callback before hid_report_raw_event()
> performs its own report-size validation, a device sending a
> truncated HID report can cause out-of-bounds heap reads in the
> kernel.
>
> In the I2C response path, xfer->length (data[1]) is used as the
> length for a memcpy into dev->read_buf. While xfer->length is
> checked against dev->read_len, there is no check that size is large
> enough to actually contain xfer->length bytes of data starting at
> offset 2. A malicious USB device could therefore cause an OOB read
> from the kernel heap, with the result accessible from userspace via
> the I2C read interface.
>
> FT260 devices use 64-byte HID reports. Add a check at the top of
> the handler to reject any report shorter than expected, and log a
> warning to aid debugging.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>
> ---
>  drivers/hid/hid-ft260.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
> index 333341e80..7ca323992 100644
> --- a/drivers/hid/hid-ft260.c
> +++ b/drivers/hid/hid-ft260.c
> @@ -1068,6 +1068,12 @@ static int ft260_raw_event(struct hid_device *hdev=
, struct hid_report *report,
>         struct ft260_device *dev =3D hid_get_drvdata(hdev);
>         struct ft260_i2c_input_report *xfer =3D (void *)data;
>
> +       /* FT260 always sends 64-byte reports */
> +       if (size < 64) {
> +               hid_warn(hdev, "report too short: %d < 64\n", size);
> +               return 0;
> +       }
> +
>         if (xfer->report >=3D FT260_I2C_REPORT_MIN &&
>             xfer->report <=3D FT260_I2C_REPORT_MAX) {
>                 ft260_dbg("i2c resp: rep %#02x len %d\n", xfer->report,
> --
> 2.43.0
>

