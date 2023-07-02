Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6C37744E57
	for <lists+stable@lfdr.de>; Sun,  2 Jul 2023 17:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjGBPfh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 2 Jul 2023 11:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGBPfg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 2 Jul 2023 11:35:36 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63330E67
        for <stable@vger.kernel.org>; Sun,  2 Jul 2023 08:35:35 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-570114e1feaso44372857b3.3
        for <stable@vger.kernel.org>; Sun, 02 Jul 2023 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google; t=1688312134; x=1690904134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8HK/wrSX5ldIZqomEmAxF+1M9WN0YB3jXi2+hEI4hrg=;
        b=eiVt0+3ZYtOex8/Q262QUkD8yO54TEKnIlojZ3iJyFecJpxx/hHFMOO2+Z+5RVMam1
         EbNVYeQRI1but0ux0fabyQ2maNA4NrkvvAs0Dq3rgyhlh3GQ12pvVjqtOh+poZrIwZNv
         t2M69Ols7woVvNIRJfGxLxpaGA2pHl5JYAuvWnjjpbyN+xMwe5YnEKMv3f7kA8T7P8Hz
         ihwfrCIoN3S6DSDtIaSeEOdhTZxEIvqtVzqx1J72Px6ZuKfcORIDu6RWjSDB8NHOPJ+x
         9XTkp+li26FCS5ghT1LO6OBFyKhNItLIdyBiKOzuWKvlsxuzdT4Aw0WUFHo4+f8jkit+
         8OcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688312134; x=1690904134;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HK/wrSX5ldIZqomEmAxF+1M9WN0YB3jXi2+hEI4hrg=;
        b=Ucpvq3pJK7w29hwreDjad/SkdjLHI9LCT4BOia6ZVyGE297DaGJJSD9ePhYfYF1atL
         ZY8Q0YWxLoOr5jSH009zqurkkOBelrWkUNgsC0nyB0SL7tUnNnNTaLXWaAeR/4voNqxx
         AZcVkLBTMQE19k7L+ndJvgnpWQrNh4Jd16NsSqnc3aX+JizLTIm7n/ZVPAX3tTD9Std3
         CO+qwXv3DLpp9B81pAy7SVDg0Y9X16AxytHYNlqHu0KQNsyxARgIWwoPyfPNCgsG7y2Z
         RYsqiudpJMWVpiMPQX9U1u53p8j+HGZ4Sqil5qhPgBOMgq4AipFUzcbQ9PhxO/ZqfR85
         SyPA==
X-Gm-Message-State: ABy/qLZjT/1npMarHxKNyu8ka9v+CgzMxxVOmAP7szHSjJ0bB1h3LPbQ
        M3PnnH0u9kirxQf4/WeZ1JT9qm3BaK2C0+Utkb9/sA==
X-Google-Smtp-Source: APBJJlF0b4377s+5bE0gPOT9vWcP0qN6qywjYOogZGjLDkgFAsoWN98kiIjISETvk66UZU5XS6FurxP1uZdzb1IyRhQ=
X-Received: by 2002:a81:5302:0:b0:56d:31a1:bd9b with SMTP id
 h2-20020a815302000000b0056d31a1bd9bmr7933811ywb.41.1688312134647; Sun, 02 Jul
 2023 08:35:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230701094723.29379-1-johan+linaro@kernel.org>
In-Reply-To: <20230701094723.29379-1-johan+linaro@kernel.org>
From:   Steev Klimaszewski <steev@kali.org>
Date:   Sun, 2 Jul 2023 10:35:23 -0500
Message-ID: <CAKXuJqjyjbRi2H=A_d=RgMOKSy=ZRqr0YVqsFObMYKtp66RyHA@mail.gmail.com>
Subject: Re: [PATCH] ASoC: codecs: wcd938x: fix soundwire initialisation race
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

On Sat, Jul 1, 2023 at 4:48=E2=80=AFAM Johan Hovold <johan+linaro@kernel.or=
g> wrote:
>
> Make sure that the soundwire device used for register accesses has been
> enumerated and initialised before trying to read the codec variant
> during component probe.
>
> This specifically avoids interpreting (a masked and shifted) -EBUSY
> errno as the variant:
>
>         wcd938x_codec audio-codec: ASoC: error at soc_component_read_no_l=
ock on audio-codec for register: [0x000034b0] -16
>
> in case the soundwire device has not yet been initialised, which in turn
> prevents some headphone controls from being registered.
>
> Fixes: 8d78602aa87a ("ASoC: codecs: wcd938x: add basic driver")
> Cc: stable@vger.kernel.org      # 5.14
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Reported-by: Steev Klimaszewski <steev@kali.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  sound/soc/codecs/wcd938x.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/sound/soc/codecs/wcd938x.c b/sound/soc/codecs/wcd938x.c
> index e3ae4fb2c4db..4571588fad62 100644
> --- a/sound/soc/codecs/wcd938x.c
> +++ b/sound/soc/codecs/wcd938x.c
> @@ -3080,9 +3080,18 @@ static int wcd938x_irq_init(struct wcd938x_priv *w=
cd, struct device *dev)
>  static int wcd938x_soc_codec_probe(struct snd_soc_component *component)
>  {
>         struct wcd938x_priv *wcd938x =3D snd_soc_component_get_drvdata(co=
mponent);
> +       struct sdw_slave *tx_sdw_dev =3D wcd938x->tx_sdw_dev;
>         struct device *dev =3D component->dev;
> +       unsigned long time_left;
>         int ret, i;
>
> +       time_left =3D wait_for_completion_timeout(&tx_sdw_dev->initializa=
tion_complete,
> +                                               msecs_to_jiffies(2000));
> +       if (!time_left) {
> +               dev_err(dev, "soundwire device init timeout\n");
> +               return -ETIMEDOUT;
> +       }
> +
>         snd_soc_component_init_regmap(component, wcd938x->regmap);
>
>         ret =3D pm_runtime_resume_and_get(dev);
> --
> 2.39.3
>

Thank you!  Tested with this and the other patch applied on my X13s
with a pair of Apple EarPods with 3.5mm Headphone Plug, audio is quite
nice through them.

Tested-by: Steev Klimaszewski <steev@kali.org>
