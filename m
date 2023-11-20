Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA877F1903
	for <lists+stable@lfdr.de>; Mon, 20 Nov 2023 17:46:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbjKTQqZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+stable@lfdr.de>); Mon, 20 Nov 2023 11:46:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233983AbjKTQqK (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 20 Nov 2023 11:46:10 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409D6198A;
        Mon, 20 Nov 2023 08:45:18 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-5841a3ffd50so167062eaf.1;
        Mon, 20 Nov 2023 08:45:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700498716; x=1701103516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WkAGuCakBDhIxabLKIQHjls5jYpV9LhzQ/PhHmuLCvo=;
        b=qaWL556B4Xz0eA/avzJMWyRrPFGpdzlTCyVDb9U8gyrzCA/BbT387hD2PXpdrOLUww
         pgQJoCl1HRfq9iZwlYJapiVMLpMYZ5Z/EKh1ixhZH38NiJGWz6ROncDagzHBEVh4aLgT
         VaAH7rIjLtPSsCA+m057tmAYzNSh8EC3wa7PKGZztW4DlLfQOSYzqdvfT8JGuS5LhEC2
         jkTYS9O9J3LGHU6WXqtBRLM8VOOlYsxNjeIASC5Ib1OH31HIwGU10UMYVqxivw1SFUIt
         gYZSowQ3BjoTNnPcZ1sT231IQCefOQwR4621TVORBxSklm6sxKB5dTv5sRUDf6tHj3xg
         vMOg==
X-Gm-Message-State: AOJu0Yy+6Zk93bi+LJAqpaK6lVZ+6ngrocWXYj/vdFPCeGmvh6MCI5LJ
        iF4kqY9rJj9dGn4suKAs0PpoTey04kBpIGFGxOo=
X-Google-Smtp-Source: AGHT+IHackjYrQx5rVRooxZCmccg59iJebELvqxZcqaB5TnjcVpdX+BBNoBZobGYh4C47X+F0VCETMkzXjyQ/CPGJes=
X-Received: by 2002:a05:6820:169:b0:583:fc94:c3fd with SMTP id
 k9-20020a056820016900b00583fc94c3fdmr7586606ood.0.1700498716704; Mon, 20 Nov
 2023 08:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20231115180222.10436-1-hdegoede@redhat.com>
In-Reply-To: <20231115180222.10436-1-hdegoede@redhat.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 20 Nov 2023 17:45:05 +0100
Message-ID: <CAJZ5v0jdf8meCstid+i=bcvr0oG_K=Sxs2FOv05EwxmJMNvpmA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: resource: Skip IRQ override on ASUS ExpertBook B1402CVA
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-acpi@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Wed, Nov 15, 2023 at 7:02 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Like various other ASUS ExpertBook-s, the ASUS ExpertBook B1402CVA
> has an ACPI DSDT table that describes IRQ 1 as ActiveLow while
> the kernel overrides it to EdgeHigh.
>
> This prevents the keyboard from working. To fix this issue, add this laptop
> to the skip_override_table so that the kernel does not override IRQ 1.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218114
> Cc: stable@vger.kernel.org
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/acpi/resource.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/drivers/acpi/resource.c b/drivers/acpi/resource.c
> index 15a3bdbd0755..9bd9f79cd409 100644
> --- a/drivers/acpi/resource.c
> +++ b/drivers/acpi/resource.c
> @@ -447,6 +447,13 @@ static const struct dmi_system_id irq1_level_low_skip_override[] = {
>                         DMI_MATCH(DMI_BOARD_NAME, "B1402CBA"),
>                 },
>         },
> +       {
> +               /* Asus ExpertBook B1402CVA */
> +               .matches = {
> +                       DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> +                       DMI_MATCH(DMI_BOARD_NAME, "B1402CVA"),
> +               },
> +       },
>         {
>                 /* Asus ExpertBook B1502CBA */
>                 .matches = {
> --

Applied as 6.7-rc material, thanks!
